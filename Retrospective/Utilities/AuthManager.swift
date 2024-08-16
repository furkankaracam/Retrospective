//
//  AuthManager.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation
import FirebaseAuth

final class AuthManager: ObservableObject {
    
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle!
    static let shared = AuthManager()
    
    init() {
        configureAuthStateChanges()
    }
    
    func signUp(username: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().createUser(withEmail: "\(username)@mail.com", password: password)
            UserDefaults.standard.setValue(false, forKey: "isAnonymUser")
            updateState(user: result.user)
            return result
        } catch {
            throw error
        }
    }
    
    func signIn(username: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(withEmail: "\(username)@mail.com", password: password)
            updateState(user: result.user)
            return result
        } catch {
            throw error
        }
    }
    
    private func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.updateState(user: user)
        }
    }
    
    private func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    
    private func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        
        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    private func checkAuthState() -> Bool {
        return user != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            updateState(user: nil)
        } catch {
            print("Error while signing out!")
        }
    }
    
    func getUserName() -> String? {
        return user?.email?.split(separator: "@").first.flatMap(String.init)
    }
}
