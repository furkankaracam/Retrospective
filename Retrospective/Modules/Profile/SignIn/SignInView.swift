//
//  SignInView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel: SignInViewModel
    
    @Binding var isPresented: Bool
    @State var isPresentedAlert: Bool = false
    @State var isPresentedPasswordWarning: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(40)
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.blue, lineWidth: 5))
                .shadow(color: .blue, radius: 10)
                .rotationEffect(.degrees(10))
                .padding()
            Text("Kullanıcı Kayıt Ekranı")
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
                Text("Parolayı tekrar giriniz:")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width / 3)
                SecureField("Parola", text: $viewModel.rePassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            if isPresentedPasswordWarning {
                Text("Şifreler uyuşmuyor!")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            HStack {
                Spacer()
                
                Button("Kaydol") {
                    Task {
                        await viewModel.signUp()
                        if viewModel.errorMessage != nil {
                            isPresentedAlert = true
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
                Button("Vazgeç") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .buttonStyle(.bordered)
            .padding()
            .alert("Hata", isPresented: $isPresentedAlert) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Bilinmeyen bir hata oluştu.")
            }
        }
        .padding()
        .onChange(of: viewModel.rePassword) { newValue in
            self.isPresentedPasswordWarning = !viewModel.checkPassword()
        }
        .onChange(of: viewModel.signStatus) { newValue in
            if newValue {
                isPresented = false
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
}

#Preview {
    SignInView(viewModel: SignInViewModel(authManager: AuthManager()), isPresented: .constant(false))
}
