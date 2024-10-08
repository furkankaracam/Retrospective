//
//  SessionDetailViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import Foundation
import Firebase

final class SessionDetailViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var session: RetroSession?
    @Published var items: [ListItem] = []
    @Published var sessionName: String = ""
    @Published var timer: Timer?
    @Published var time: String?
    @Published var sessionKey: String = ""
    @Published var authorVisibility: Bool = true
    @Published var isSessionActive: Bool = true
    
    private let ref = Database.database().reference()
    private var authManager = AuthManager.shared
    
    // MARK: - Fetch session key
    private func getKey(id: String, completion: @escaping (String?) -> Void) {
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
    
    // MARK: - Timer functions
    func startTimer(id: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTime()
        }
    }
    
    private func updateTime() {
        guard let endTime = session?.settings?.endTime else { return }
        
        let currentTime = Date().timeIntervalSince1970
        let remainingTime = max(0, endTime - currentTime)
        
        if remainingTime == 0 {
            self.isSessionActive = false
            self.timer?.invalidate()
            self.ref.child("sessions/\(sessionKey)/isActive").setValue(false) { error, _ in
                if let error = error {
                    print("Error updating session status: \(error.localizedDescription)")
                }
            }
        }
        
        self.time = TimeFormatterUtility.formatTime(seconds: Int(remainingTime))
    }
    
    // MARK: - Comments functions
    
    private func deleteComment(sessionId: String, columnId: String, commentId: String) async {
        let commentRef = ref.child("sessions").child(sessionId).child("columns").child(columnId).child("comments").child(commentId)
        do {
            try await commentRef.removeValue()
        } catch {
            print("Error deleting comment: \(error.localizedDescription)")
        }
    }
    
    func addComment(sessionId: String, to column: String, comment: String) async {
        let newCommentId = UUID().uuidString
        let author = UserDefaults.standard.bool(forKey: "isAnonymUser") ? (authManager.getUserName() ?? "") : "Anonim"
        let newComment = Comment(id: newCommentId, author: author, comment: comment, order: findMaxOrder(columnId: column) + 1)
        
        print("Adding comment: \(comment) to column: \(column)")
        
        do {
            let commentsRef = ref.child("sessions/\(sessionKey)/columns/\(column)/comments")
            try await commentsRef.child(newComment.id ?? "0").setValue([
                "id": String(newComment.id!),
                "author": String(newComment.author!),
                "comment": String(newComment.comment!),
                "order": Int(newComment.order!)
            ])
            print("Comment added successfully")
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
        }
    }
    
    private func findMaxOrder(columnId: String) -> Int {
        return items
            .filter { $0.isComment && $0.column?.id == columnId }
            .map { $0.comment?.order ?? 0 }
            .max() ?? 0
    }
    
    // MARK: - Columns functions
    func fetchColumns(id: String) async {
        guard let key = await withCheckedContinuation({ continuation in
            getKey(id: id) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }) else { return }
        
        ref.child("sessions").child(key).observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(RetroSession.self, from: data)
                
                DispatchQueue.main.async {
                    self.session = session
                    self.authorVisibility = session.settings?.authorVisibility ?? true
                    self.updateParticipants(for: session.participants, key: key)
                    self.items = self.createListItems(from: session)
                }
            } catch {
                print("Decode error: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateParticipants(for participants: [String: Int]?, key: String) {
        let currentUser = authManager.getUserName() ?? ""
        var updatedParticipants = participants ?? [:]
        
        if updatedParticipants[currentUser] == nil {
            updatedParticipants[currentUser] = 1
            ref.child("sessions").child(key).child("participants").setValue(updatedParticipants) { error, _ in
                if let error = error {
                    print("Error updating participants: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func createListItems(from session: RetroSession) -> [ListItem] {
        var newItems: [ListItem] = []
        
        if let columns = session.columns {
            let sortedColumns = columns.values.sorted { ($0.name ?? "") < ($1.name ?? "") }
            
            for column in sortedColumns {
                newItems.append(ListItem(id: column.id ?? "", isComment: false, comment: nil, column: column))
                
                if let comments = column.comments {
                    let sortedComments = comments.values.sorted { ($0.order ?? 0) < ($1.order ?? 0) }
                    
                    for comment in sortedComments {
                        newItems.append(ListItem(id: comment.id ?? "", isComment: true, comment: comment, column: column))
                    }
                }
            }
        }
        return newItems
    }
    
    // MARK: - Drag and drop functions
    
    func moveItems(fromOffsets source: IndexSet, toOffset destination: Int) {
        var newItems = self.items
        
        guard let sourceIndex = source.first else {
            print("Source index not found")
            return
        }
        
        let adjustedDestination = destination > sourceIndex ? destination - 1 : destination
        
        guard sourceIndex < newItems.count, adjustedDestination <= newItems.count else {
            print("Invalid source or destination index")
            return
        }
        
        let movedItem = newItems.remove(at: sourceIndex)
        newItems.insert(movedItem, at: adjustedDestination)
        
        let oldColumnId = findColumnId(forCommentAt: sourceIndex)
        let newColumnId = findColumnId(forCommentAt: adjustedDestination)
        
        let itemsCopy = newItems
        
        Task {
            if oldColumnId != newColumnId {
                if let movedComment = movedItem.comment {
                    await deleteComment(sessionId: sessionKey, columnId: oldColumnId ?? "", commentId: movedComment.id ?? "")
                    await addComment(sessionId: sessionKey, to: newColumnId ?? "", comment: movedComment.comment ?? "")
                }
            }
            await updateOrderInColumn(columnId: newColumnId ?? "", items: itemsCopy.filter { $0.column?.id == newColumnId })
        }
        
        self.items = newItems
    }
    
    func deleteItem(at index: Int) {
        let item = items[index]
        
        if item.isComment, let commentId = item.comment?.id {
            if let columnId = findColumnId(forCommentAt: index) {
                Task {
                    await deleteComment(sessionId: sessionKey, columnId: columnId, commentId: commentId)
                }
            } else {
                print("Column ID for comment \(commentId) not found")
            }
        }
    }
    
    // MARK: - Helper Functions
    
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
    
    private func updateOrderInColumn(columnId: String, items: [ListItem]) async {
        for (index, item) in items.enumerated() {
            if item.isComment, let commentId = item.comment?.id {
                let order = index + 1
                do {
                    try await ref.child("sessions/\(sessionKey)/columns/\(columnId)/comments/\(commentId)/order").setValue(order)
                } catch {
                    print("Error updating comment order: \(error.localizedDescription)")
                }
            }
        }
    }
}
