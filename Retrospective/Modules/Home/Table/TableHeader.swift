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
                .frame(width: geometry.size.width - 20, height: 50)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .overlay(
                    HStack(alignment: .center) {
                        Text("Retro İsmi")
                        Spacer()
                        Text("Durumu")
                        Spacer()
                        Text("İşlemler")
                    }
                        .font(.title3)
                        .foregroundColor(.white)
                        .underline()
                        .padding(.horizontal, 24)
                )
        }
        .frame(height: 50)
    }
}

#Preview {
    TableHeader()
}
