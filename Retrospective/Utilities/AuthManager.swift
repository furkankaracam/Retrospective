//
//  AuthManager.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle!
    
    init() {
        configureAuthStateChanges()
    }
    
    func signUp(username: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().createUser(withEmail: "\(username)@mail.com", password: password)
            UserDefaults.standard.setValue(false, forKey: "isAnonymUser")
            return result
        } catch {
            throw error
        }
    }
    
    func signInAnonymously() async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signInAnonymously()
            return result
        } catch {
            throw error
        }
    }
    
    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.updateState(user: user)
        }
    }
    
    func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    
    func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        
        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    func checkAuthState() -> Bool {
        user != nil ? true : false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error while signing out!")
        }
    }
}
