//
//  ProfileView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel: SignUpViewModel
    @State private var isPresented: Bool = false
    @State private var authStatus: Bool = false
    @State private var anonymStatus: Bool = false
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: SignUpViewModel(authManager: authManager))
    }
    
    var body: some View {
        VStack(spacing: 15) {
            if !authStatus {
                LogoView()
                Text("Kullanıcı Giriş Ekranı")
                    .font(.title)
                HStack {
                    Text("Kullanıcı Adı:")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width / 3)
                    TextField("Kullanıcı adı giriniz", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack {
                    Text("Parola:")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width / 3)
                    SecureField("Parola", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                HStack {
                    Spacer()
                    Button("Giriş Yap") {
                        Task {
                            await viewModel.signIn()
                            authStatus = await viewModel.checkAuth()
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button("Kaydol") {
                        isPresented = true
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: Binding<Bool>(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )) {
                    Alert(
                        title: Text("Hata"),
                        message: Text(viewModel.errorMessage ?? "Bilinmeyen bir hata oluştu"),
                        dismissButton: .default(Text("Tamam"))
                    )
                }
            } else {
                // Profil ekranı
                VStack(spacing: 15) {
                    LogoView()
                    Text("HOŞGELDİNİZ!")
                        .bold()
                    HStack {
                        Text("Kullanıcı Adım: ")
                            .bold()
                        TextField("Kullanıcı Adı", text: .constant(String(viewModel.user?.email?.split(separator: "@").first ?? "")))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Oturumlarda Adım Gözüksün: ")
                            .bold()
                        Toggle("", isOn: $anonymStatus)
                            .onChange(of: anonymStatus) { newValue in
                                Task {
                                    viewModel.changeAnonymStatus(isAnonym: newValue)
                                    anonymStatus = viewModel.readAnonymStatus()
                                }
                            }
                    }
                    Text("Bu seçeneği açtığınızda, eğer oturum yöneticisi isimleri gizlemediyse isminiz gözükecektir.")
                        .font(.caption)
                    Button("Çıkış yap") {
                        Task {
                            await viewModel.logout()
                            authStatus = await viewModel.checkAuth()
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
                .padding()
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isPresented) {
            SignInView(viewModel: SignInViewModel(authManager: AuthManager()), isPresented: $isPresented)
        }
        .onAppear {
            Task {
                anonymStatus = viewModel.readAnonymStatus()
                authStatus = await viewModel.checkAuth()
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    SignUpView(authManager: AuthManager())
}
