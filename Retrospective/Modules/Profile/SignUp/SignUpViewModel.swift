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
    @Published var errorMessage: String?
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        self.user = authManager.user
    }
    
    func signIn() async {
        do {
            try await authManager.signIn(username: name, password: password)
            await MainActor.run {
                self.user = self.authManager.user
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
            }
        }
    }
    
    private func signUp() async {
        do {
            try await authManager.signUp(username: name, password: password)
            await MainActor.run {
                self.user = self.authManager.user
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
            }
        }
    }
    
    private func checkPassword() -> Bool {
        return password == rePassword
    }
    
    private func checkAuth() async -> Bool {
        await MainActor.run {
            return self.authManager.authState == .signedIn
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
