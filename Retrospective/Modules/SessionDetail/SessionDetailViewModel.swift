//
//  SessionDetailViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import Foundation
import Firebase

final class SessionDetailViewModel: ObservableObject {
    
    @Published var items: [ListItem] = []
    @Published var sessionName: String = ""
    @Published var timer: Timer?
    @Published var time: String?
    @Published var sessionKey: String = ""
    @Published var anonymStatus: Bool?
    
    private let ref = Database.database().reference()
    
    private var authManager = AuthManager.shared
    
    func getKey(id: String, completion: @escaping (String?) -> Void) {
        ref.child("sessions").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                completion(nil)
                return
            }
            
            for (key, session) in value {
                if let sessionDict = session as? [String: Any], let sessionId = sessionDict["id"] as? String, sessionId == id {
                    self.sessionKey = key
                    completion(key)
                    return
                }
            }
            
            completion(nil)
        }
    }
    
    func startTimer(id: String) {
        let key = sessionKey
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTime(key: key)
        }
    }
    
    private func updateTime(key: String) {
        ref.child("sessions/\(key)/settings/time").observeSingleEvent(of: .value) { snapshot in
            guard let currentTime = snapshot.value as? Int else {
                print("Error: Could not retrieve time value.")
                return
            }
            
            self.ref.child("sessions/\(key)/settings/time").setValue(currentTime - 1) { error, _ in
                if let error = error {
                    print("Error updating time value: \(error.localizedDescription)")
                } else {
                    self.time = TimeFormatterUtility.formatTime(seconds: currentTime - 1)
                }
            }
        }
    }
    
    func deleteComment(sessionId: String, columnId: String, commentId: String) async {
        let commentRef = ref.child("sessions").child(sessionId).child("columns").child(columnId).child("comments").child(commentId)
        print("Çalışan \(commentRef)")
        do {
            try await commentRef.removeValue()
        } catch {
            print("Error deleting comment: \(error)")
        }
    }
    
    func fetchColumns(id: String) async {
        let key = await withCheckedContinuation { continuation in
            getKey(id: id) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }
        
        guard let key = key else { return }
        
        ref.child("sessions").child(key).observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(RetroSession.self, from: data)
                
                DispatchQueue.main.async {
                    self.anonymStatus = session.settings?.anonymous ?? false
                    
                    let currentUser = self.authManager.getUserName() ?? ""
                    if var participants = session.participants {
                        if participants[currentUser] == nil {
                            participants[currentUser] = 1
                            self.ref.child("sessions").child(key).child("participants").setValue(participants) { error, _ in
                                if let error = error {
                                    print("Error updating participants: \(error.localizedDescription)")
                                }
                            }
                        }
                    } else {
                        let newParticipants: [String: Int] = [currentUser: 1]
                        self.ref.child("sessions").child(key).child("participants").setValue(newParticipants) { error, _ in
                            if let error = error {
                                print("Error setting participants: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    var newItems: [ListItem] = []
                    
                    if let columns = session.columns {
                        let sortedColumns = columns.values.sorted { ($0.name ?? "") < ($1.name ?? "") }
                        
                        for column in sortedColumns {
                            newItems.append(ListItem(id: column.id ?? "", isComment: false, comment: nil, column: column))
                            
                            if let comments = column.comments {
                                let sortedComments = comments.values.sorted { ($0.order ?? 0) < ($1.order ?? 0) }
                                
                                for comment in sortedComments {
                                    newItems.append(ListItem(id: comment.id ?? "", isComment: true, comment: comment, column: nil))
                                }
                            }
                        }
                    }
                    self.items = newItems
                }
            } catch {
                print("Decode error: \(error)")
            }
        }
    }
    
    func addComment(sessionId: String, to column: String, comment: String) async {
        let newCommentId = UUID().uuidString
        
        var author = ""
        
        if !UserDefaults.standard.bool(forKey: "isAnonymUser") {
            author = "Anonim"
        } else {
            if let name = authManager.getUserName() {
                author = name
            }
        }
        
        var newComment = Comment(id: newCommentId, author: author, comment: comment, order: 1)
        
        do {
            newComment.order = findMaxOrder(columnId: column) + 1
                
            let commentsRef = ref.child("sessions/\(sessionKey)/columns/\(column)/comments")
            
            try await commentsRef.child(newComment.id ?? "0").setValue([
                "id": newComment.id,
                "author": newComment.author,
                "comment": newComment.comment,
                "order": newComment.order
            ])
        } catch {
            print("Error adding comment: \(error)")
        }
    }
    
    private func findMaxOrder(columnId: String) -> Int {
        var max = 0
        for item in items.reversed() {
            if item.isComment && item.comment?.order ?? 0 > max {
                max = item.comment?.order ?? 0
            }
            if !item.isComment && item.column?.id == columnId {
                return max
            }
        }
        return 0
    }
    
    private func findColumnId(forCommentAt index: Int) -> String? {
        guard index >= 0 else { return nil }
        
        for index in (0..<index).reversed() {
            let item = self.items[safe: index]
            if let item = item, !item.isComment, let id = item.column?.id {
                return id
            }
        }
        return nil
    }
    
    func updateOrderInColumn(columnId: String, items: [ListItem]) async {
        for (index, item) in items.enumerated() {
            if item.isComment, let commentId = item.comment?.id {
                let order = index + 1
                do {
                    try await ref.child("sessions/\(sessionKey)/columns/\(columnId)/comments/\(commentId)/order").setValue(order)
                } catch {
                    print("Error updating comment order: \(error)")
                }
            }
        }
    }
    
}
