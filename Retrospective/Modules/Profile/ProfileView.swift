//
//  ProfileView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewController()
    
    @Binding var name: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 5,  content: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(40)
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.blue, lineWidth: 5))
                .shadow(color: .blue, radius: 10)
                .rotationEffect(.degrees(10))
                .padding()
                .padding()
            HStack(content: {
                Text("Kullanıcı Adı:")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width / 3)
                TextField("Kullanıcı adı giriniz", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            })
            HStack(content: {
                Text("Parola:")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width / 3)
                    
                SecureField("Parola", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
            })
            HStack(content: {
                Group {
                    Button("Giriş Yap") {
                        
                    }
                    Button("Kaydol") {
                        
                    }
                    .tint(.green)
                }
                .buttonStyle(.bordered)
            })
            .padding()
            
        })
        .padding()
        
    }
}

#Preview {
    ProfileView(name: .constant("Furkan"), password: .constant("Karaçam"))
}
