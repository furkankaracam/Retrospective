//
//  SignInViewController.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 8.08.2024.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    @Published var errorMessage: String?
    @Published var signStatus: Bool = false
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signUp() async {
        if !name.isEmpty && !password.isEmpty && checkPassword() {
            do {
                try await authManager.signUp(username: name, password: password)
                DispatchQueue.main.async {
                    self.signStatus = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Kayıt Başarısız: \(error.localizedDescription)"
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Lütfen tüm alanları doldurduğunuzdan ve şifrelerin eşleştiğinden emin olun."
            }
        }
    }
    
    func checkPassword() -> Bool {
        return password == rePassword
    }
}
