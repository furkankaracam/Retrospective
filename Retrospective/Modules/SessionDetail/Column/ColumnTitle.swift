//
//  ColumnTitle.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct ColumnTitle: View {
    var title: String
    var body: some View {
        VStack {
            Text(title)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .bold()
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.white)
        .border(Color.black, width: 1)
        .cornerRadius(10)
    }
}

#Preview {
    ColumnTitle(title: "Başlık")
}
