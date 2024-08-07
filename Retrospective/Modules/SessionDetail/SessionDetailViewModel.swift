//
//  SessionDetailViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import Foundation
import Firebase

final class SessionDetailViewModel: ObservableObject {
    
    @Published var columns: [Column] = []
    @Published var sessionName: String = ""
    @Published var timer: Timer?
    @Published var time: String?
    @Published var sessionKey: String = ""
    
    private let ref = Database.database().reference()
    
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
        print(sessionKey)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTime(key: key)
        }
    }
    
    private func updateTime(key: String) {
        print("updatetime")
        ref.child("sessions/\(key)/settings/time").observeSingleEvent(of: .value) { snapshot in
            guard let currentTime = snapshot.value as? Int else {
                print("Error: Could not retrieve time value.")
                return
            }
            
            let newTime = currentTime - 1
            
            self.ref.child("sessions/\(key)/settings/time").setValue(newTime) { error, _ in
                if let error = error {
                    print("Error updating time value: \(error.localizedDescription)")
                } else {
                    self.time = TimeFormatterUtility.formatTime(seconds: newTime)
                }
            }
        }
    }
    
    func deleteComment(sessionId: String, columnId: String, commentId: String) async {
        let commentRef = ref.child("sessions").child(sessionId).child("columns").child(columnId).child("comments").child(commentId)

        do {
            try await commentRef.removeValue()
            print("Yorum başarıyla silindi")
        } catch {
            print("Yorum silme hatası: \(error)")
        }
    }
    
    func fetchColumns(id: String) async {
        let key = await withCheckedContinuation { continuation in
            getKey(id: id) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }
        
        guard let key = key else {
            print("Session key not found")
            return
        }
        
        ref.child("sessions").child(key).observe(.value) { snapshot  in
            print(snapshot)
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(Session.self, from: data)
                
                DispatchQueue.main.async {
                    if let columns = session.columns {
                        var sortedColumns = Array(columns.values).sorted { $0.name ?? "" < $1.name ?? "" }
                        self.columns = sortedColumns
                        
                    }
                    
                }
            } catch {
                print("Decode error: \(error)")
            }
        }
    }
    
    func addComment(sessionId: String, to column: String, comment: String) async {
        let newCommentId = UUID().uuidString
        let newComment = Comment(id: newCommentId, author: "Kullanıcı", comment: comment)
        
        let key = await withCheckedContinuation { continuation in
            getKey(id: sessionId) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }
        
        guard let key = key else {
            print("Session key not found")
            return
        }
        
        ref.child("sessions").child(key).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(Session.self, from: data)
                
                DispatchQueue.main.async {
                    if let columns = session.columns {
                        self.columns = Array(columns.values).sorted(by: { $0.name ?? "" < $1.name ?? ""})
                    }
                    
                }
            } catch {
                print("Decode error: \(error)")
            }
        }
        
        do {
            try await ref.child("sessions/\(key)/columns/\(column)/comments/\(newCommentId)")
                .setValue(["id": newComment.id, "author": newComment.author, "comment": newComment.comment])
        } catch {
            print("Error")
        }
        
    }
}
