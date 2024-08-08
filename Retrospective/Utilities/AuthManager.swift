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
            print("FirebaseAuthSuccess: Sign in anonymously, UID:(\(user?.email)")
            return result
        }
        catch {
            print("FirebaseAuthError: failed to sign in anonymously: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signInAnonymously() async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signInAnonymously()
            print("FirebaseAuthSuccess: Sign in anonymously, UID:(\(String(describing: result.user.uid)))")
            return result
        }
        catch {
            print("FirebaseAuthError: failed to sign in anonymously: \(error.localizedDescription)")
            throw error
        }
    }
    
    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            print("Auth changed: \(user != nil)")
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
        if ((user) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error while signing out!")
        }
    }
}
