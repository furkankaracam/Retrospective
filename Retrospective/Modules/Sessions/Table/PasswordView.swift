//
//  PasswordView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 9.08.2024.
//

import SwiftUI

struct PasswordView: View {
    
    @Binding var isPresented: Bool
    @Binding var isAuthenticated: Bool
    @State private var enteredPassword: String = ""
    @State private var showAlert = false
    @EnvironmentObject private var viewModel: SessionViewModel
    
    var correctPassword: String
    
    var body: some View {
        PageHeader(image: "sessions", pageName: "Lütfen Oturum Parolasını Giriniz!")
        
        VStack {
            SecureField("Oturuma katılım parolanızı giriniz!", text: $enteredPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack(spacing: 15) {
                Button(action: {
                    if viewModel.authenticate(password: enteredPassword) {
                        isAuthenticated = true
                        isPresented = false
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
                    isPresented = false
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
        .onDisappear {
            viewModel.isAuthenticated = false
        }
    }
}


#Preview {
    PasswordView(isPresented: .constant(true), isAuthenticated: .constant(false), correctPassword: "password")
        .environmentObject(SessionViewModel())
}
