//
//  SelectNameView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectNameView: View {
    
    @State private var name: String = ""
    @StateObject var viewModel: AddSessionViewModel
    
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
            if viewModel.name.isEmpty {
                self.name = viewModel.name
            }
        }
        .onChange(of: name, {viewModel.session.name = name})
    }
}

#Preview {
    SelectNameView(viewModel: AddSessionViewModel())
}
