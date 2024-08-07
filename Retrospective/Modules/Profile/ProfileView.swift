//
//  ProfileView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewController

    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: ProfileViewController(authManager: authManager))
    }

    var body: some View {
        VStack(spacing: 5) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(40)
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.blue, lineWidth: 5))
                .shadow(color: .blue, radius: 10)
                .rotationEffect(.degrees(10))
                .padding()
            
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
                Button("Giriş Yap") {
                    Task {
                        await viewModel.signIn()
                    }
                }
                Button("Kaydol") {
                    viewModel.signUp()
                }
                .tint(.green)
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ProfileView(authManager: AuthManager())
}

