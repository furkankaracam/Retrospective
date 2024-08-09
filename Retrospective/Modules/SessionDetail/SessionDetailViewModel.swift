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
        
        do {
            try await commentRef.removeValue()
        } catch {
            print(error)
        }
    }
    
    func fetchColumns(id: String) async {
        let key = await withCheckedContinuation { continuation in
            getKey(id: id) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }
        
        guard let key else { return }
        
        ref.child("sessions").child(key).observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(RetroSession.self, from: data)
                
                DispatchQueue.main.async {
                    self.anonymStatus = session.settings?.anonymous ?? false
                    
                    if let columns = session.columns {
                        let sortedColumns = Array(columns.values).sorted { $0.name ?? "" < $1.name ?? "" }
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

        var author = ""
        
        if !UserDefaults.standard.bool(forKey: "isAnonymUser") {
            author = "Anonim"
        } else {
            if let name = authManager.getUserName() {
                author = name
            }
        }

        let newComment = Comment(id: newCommentId, author: author, comment: comment)

        let key = await withCheckedContinuation { continuation in
            getKey(id: sessionId) { resultKey in
                continuation.resume(returning: resultKey)
            }
        }

        guard let key = key else {
            print("Session key not found")
            return
        }

        do {
            try await ref.child("sessions/\(key)/columns/\(column)/comments/\(newCommentId)")
                .setValue(["id": newComment.id, "author": newComment.author, "comment": newComment.comment])
        } catch {
            print("Error adding comment: \(error)")
        }
    }
}
