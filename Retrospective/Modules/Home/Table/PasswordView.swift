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
    
    var correctPassword: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lock.fill")
                Text("Şifre Girişi")
                    .font(.headline)
                    .padding()
            }
            
            
            SecureField("Oturuma katılım parolanızı giriniz!", text: $enteredPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Giriş Yap") {
                    if enteredPassword == correctPassword {
                        isAuthenticated = true
                        isPresented = false
                    } else {
                        showAlert = true
                    }
                }
                .padding()
                .buttonStyle(.bordered)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Hata"), message: Text("Şifre yanlış. Lütfen tekrar deneyin."), dismissButton: .default(Text("Tamam")))
                }
                
                Button("Vazgeç") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                .tint(.red)
                .padding()
            }
           
        }
        .padding()
        .onDisappear(perform: {
            isAuthenticated = false
        })
    }
}

#Preview {
    PasswordView(isPresented: .constant(true), isAuthenticated: .constant(false), correctPassword: "password")
}
