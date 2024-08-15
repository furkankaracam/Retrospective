//
//  PasswordView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 9.08.2024.
//

import SwiftUI

struct PasswordView: View {
    let session: RetroSession
    @EnvironmentObject private var viewModel: SessionViewModel
    @State private var enteredPassword: String = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            PageHeader(image: "sessions", pageName: "Lütfen Oturum Parolasını Giriniz!")
            
            SecureField("Oturuma katılım parolanızı giriniz!", text: $enteredPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack(spacing: 15) {
                Button(action: {
                    if viewModel.authenticate(password: enteredPassword, for: session) {
                        viewModel.isAuthenticated = true
                        viewModel.selectedSession = session
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Giriş Yap")
                        .frame(maxWidth: .infinity, maxHeight: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Hata"),
                        message: Text("Şifre yanlış. Lütfen tekrar deneyin."),
                        dismissButton: .default(Text("Tamam"))
                    )
                }
                
                Button(action: {
                    viewModel.isAuthenticated = false
                }) {
                    Text("Vazgeç")
                        .frame(maxWidth: .infinity, maxHeight: 35)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}


