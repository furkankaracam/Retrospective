//
//  HomeViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import Foundation
import Firebase

final class SessionViewModel: ObservableObject {
    
    @Published var sessions: [RetroSession] = []
    @Published var isLoading: Bool = true
    @Published var isAuthenticated: Bool = false
    @Published var selectedSession: RetroSession?
    
    private let correctPassword = ""
    private let ref = Database.database().reference()
    
    func fetchData(type: SessionType) async {
        ref.child("sessions").observe(.value) { snapshot, _ in
            guard let value = snapshot.value as? [String: Any] else {
                print("Error: Unable to cast snapshot value")
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                let decoder = JSONDecoder()
                
                let sessionsResponse = try decoder.decode([String: RetroSession].self, from: data)
                
                DispatchQueue.main.async {
                    self.sessions = []
                    sessionsResponse.values.forEach { session in
                        if let activeStatus = session.isActive {
                            switch type {
                            case .session:
                                if activeStatus {
                                    self.sessions.append(session)
                                }
                            case .oldSession:
                                if !activeStatus {
                                    self.sessions.append(session)
                                }
                            }
                        }
                    }
                    self.sessions = self.sessions.sorted {
                        $0.name ?? "" < $1.name ?? ""
                    }
                    
                    self.isLoading = false
                }
                
            } catch {
                print("Error home decoding data: \(error)")
            }
        } withCancel: { error in
            print(error.localizedDescription)
        }
    }
    
    func authenticate(password: String, for session: RetroSession) -> Bool {
        if password == correctPassword {
            selectedSession = session
            isAuthenticated = true
            return true
        } else {
            return false
        }
    }
}
