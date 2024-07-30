//
//  SelectNameView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectNameView: View {
    
    @State private var name: String = ""
    @EnvironmentObject private var newSession: SessionData
    
    var body: some View {
        VStack {
            Text("Merhaba Furkan")
                .bold()
                .padding(.top)
                .padding(.bottom)
            Text("Oluşturmak istediğin oturuma bir isim belirle")
            TextField("Başlık", text: $name)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
        }.onAppear {
            if !newSession.name.isEmpty {
                self.name = newSession.name
            }
        }
        .onChange(of: name, {newSession.name = name})
    }
}

#Preview {
    SelectNameView()
        .environmentObject(SessionData())
}
