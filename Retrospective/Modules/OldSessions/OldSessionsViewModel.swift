//
//  OldSessionsViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation
import Firebase

final class OldSessionsViewModel: ObservableObject {

    @Published var oldSessions: [RetroSession] = []
    
    private let ref = Database.database().reference()
    private let authManager = AuthManager()
    
    func fetchData() async {
        let currentUser = authManager.getUserName() ?? "Anonim"
        
        ref.child("sessions").observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Error: Unable to cast snapshot value")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                let decoder = JSONDecoder()
                
                let sessionsResponse = try decoder.decode([String: RetroSession].self, from: data)
                
                DispatchQueue.main.async {
                    self.oldSessions = []
                    for session in sessionsResponse.values {
                        if let activeStatus = session.isActive, !activeStatus {
                            if let participants = session.participants, participants[currentUser] != nil {
                                self.oldSessions.append(session)
                            }
                        }
                    }
                }
                
            } catch {
                print("Error decoding data: \(error)")
            }
        } withCancel: { error in
            print(error.localizedDescription)
        }
    }

}
