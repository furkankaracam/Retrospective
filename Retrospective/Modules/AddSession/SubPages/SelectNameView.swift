//
//  SelectNameView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectNameView: View {
    @State var name: String = ""
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
            NavigationButtons(index: 0, checkFunction: .name(name: name))
        }
    }
}

#Preview {
    SelectNameView()
}
