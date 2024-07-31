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
        Rectangle()
            .frame(width: UIScreen.main.bounds.width - 20, height: 40)
            .overlay {
                Text(title)
                    .background(.clear)
                    .frame(width: UIScreen.main.bounds.width, height: 30)
                    .foregroundColor(.white)
                    .bold()
            }
            .cornerRadius(15)
    }
}

#Preview {
    ColumnTitle(title: "Başlık")
}
