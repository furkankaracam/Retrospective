//
//  HomeViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import Foundation
import Firebase

final class HomeViewModel: ObservableObject {
    
    @Published var sessions: [Session] = []
    @Published var oldSessions: [Session] = []
    
    private let ref = Database.database().reference()
    
    func fetchData() async {
        ref.child("sessions").observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Error: Unable to cast snapshot value")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                let decoder = JSONDecoder()
                
                let sessionsResponse = try decoder.decode([String: Session].self, from: data)
                
                DispatchQueue.main.async {
                    self.sessions = []
                    self.oldSessions = []
                    sessionsResponse.values.forEach { session in
                        if let activeStatus = session.isActive {
                            if activeStatus {
                                self.sessions.append(session)
                            } else {
                                self.oldSessions.append(session)
                            }
                        }
                    }
                }
                
            } catch {
                print("Error home decoding data: \(error)")
            }
        } withCancel: { error in
            print(error.localizedDescription)
        }
    }
}
