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
    
    func signIn() async {
        if name != "" && password != "" && checkPassword(rePassword: rePassword) {
            do {
                try await authManager.signUp(username: name, password: password)
                signStatus = true
            } catch {
                errorMessage = "Kayıt Başarısız \(error.localizedDescription)"
            }
        } else {
            errorMessage = "Lütfen tüm alanları doldurduğunuzdan ve şifrelerin eşleştiğinden emin olun."
        }
    }
    
    func checkPassword(rePassword: String) -> Bool {
        return password == rePassword
    }
}
