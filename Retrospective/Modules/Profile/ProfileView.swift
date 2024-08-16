//
//  ProfileView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 16.08.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: SignUpViewModel
    @State private var anonymStatus: Bool = false
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: SignUpViewModel(authManager: authManager))
    }
    
    var body: some View {
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
                }
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .padding()
        .onAppear {
            Task {
                anonymStatus = viewModel.readAnonymStatus()
            }
        }
    }
}

#Preview {
    ProfileView(authManager: AuthManager())
}
