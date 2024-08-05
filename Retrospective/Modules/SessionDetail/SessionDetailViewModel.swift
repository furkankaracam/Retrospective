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
    
    func fetchColumns(id: String) async {
        ref.child("sessions").child(id).observe(.value) { snapshot in
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
    
    func addComment(to column: String, comment: String) {
        let newCommentId = UUID().uuidString
        let newComment = Comment(id: newCommentId, author: "Kullanıcı", comment: comment)
        
        print(column ?? "gelmedi")
        
        ref.child("sessions")
            .child("-O32r_g1dkf9kWSVf6Xr")
            .child("columns")
            .child(column)
            .child("comments")
            .child(newCommentId)
            .setValue(["id": newComment.id, "author": newComment.author, "comment": newComment.comment])
    }
}
