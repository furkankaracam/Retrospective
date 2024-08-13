//
//  ProfileViewController.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation
import FirebaseAuth

final class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    @Published var user: User?
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        self.user = authManager.user
    }
    
    func signIn() async {
        do {
            try await authManager.signInAnonymously()
            print("Giriş başarılı")
            await MainActor.run {
                self.user = self.authManager.user
            }
        } catch {
            print("Giriş başarısız: \(error.localizedDescription)")
        }
    }
    
    func signUp() {
        print(self.authManager.authState)
    }
    
    func checkPassword() -> Bool {
        return password != rePassword
    }
    
    func checkAuth() async -> Bool {
        await MainActor.run {
            self.authManager.checkAuthState()
        }
    }
    
    func logout() async {
        authManager.signOut()
        await MainActor.run {
            self.user = nil
        }
    }
    
    func readAnonymStatus() -> Bool {
        UserDefaults.standard.bool(forKey: "isAnonymUser")
    }
    
    func changeAnonymStatus(isAnonym: Bool) {
        UserDefaults.standard.set(isAnonym, forKey: "isAnonymUser")
    }
}
