//
//  TableHeader.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct TableHeader: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.blue)
                .frame(width: geometry.size.width - 20, height: 40)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .overlay(
                    HStack() {
                        Text("Retro İsmi")
                            .frame(width: geometry.size.width / 2)
                        Spacer()
                        Text("İşlemler")
                            .frame(width: geometry.size.width / 2)
                    }
                        .font(.title3)
                        .foregroundColor(.white)
                        .underline()
                        .padding(.horizontal)
                )
        }
        .frame(height: 40)
    }
}

#Preview {
    TableHeader()
}
