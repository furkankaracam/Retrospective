//
//  ProfileViewController.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signIn() async {
        do {
            try await authManager.signInAnonymously()
            print("Giriş başarılı")
        } catch {
            print("Giriş başarısız: \(error.localizedDescription)")
        }
    }
    
    func signUp() {
        print(self.authManager.authState)
    }
    
    func checkPassword(rePassword: String) -> Bool {
        if password == rePassword {
            return false
        }
        return true
    }
    
    func checkAuth() -> Bool {
        authManager.checkAuthState()
    }
    
    func logout() {
        authManager.signOut()
    }
}
