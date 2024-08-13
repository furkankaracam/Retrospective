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
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                    .overlay(
                        Text(title)
                            .font(.title3)
                            .foregroundColor(.blue)
                    )
            )
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width, height: 50)
    }
}

#Preview {
    ColumnTitle(title: "Başlık")
}
