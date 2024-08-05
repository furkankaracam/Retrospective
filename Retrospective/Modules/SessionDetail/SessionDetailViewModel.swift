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
    
    private let ref = Database.database().reference()
    
    private func getKey(id: String, completion: @escaping (String?) -> Void) {
        ref.child("sessions").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                completion(nil)
                return
            }
            
            for (key, session) in value {
                if let sessionDict = session as? [String: Any], let sessionId = sessionDict["id"] as? String, sessionId == id {
                    completion(key)
                    return
                }
            }
            
            completion(nil)
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
        
        ref.child("sessions").child(key).observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                
                let session = try decoder.decode(Session.self, from: data)
                
                DispatchQueue.main.async {
                    self.columns = Array(session.columns.values)
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
                    self.columns = Array(session.columns.values)
                }
            } catch {
                print("Decode error: \(error)")
            }
        }
        
        do{
            try await ref.child("sessions")
                .child(key)
                .child("columns")
                .child(column)
                .child("comments")
                .child(newCommentId)
                .setValue(["id": newComment.id, "author": newComment.author, "comment": newComment.comment])
        }   catch {
            print("Error")
        }
        
    }
}
