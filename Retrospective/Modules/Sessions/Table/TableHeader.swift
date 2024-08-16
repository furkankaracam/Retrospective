//
//  TableHeader.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct TableHeader: View {
    
    var isOld: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.blue)
                .frame(width: geometry.size.width - 20, height: 40)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .overlay(
                    HStack {
                        Text("Retro İsmi")
                            .frame(width: geometry.size.width / 2)
                            .font(.headline)
                        Spacer()
                        if !isOld {
                            Text("Zaman")
                                .frame(width: geometry.size.width / 2)
                                .font(.headline)
                            Spacer()
                        }
                    }
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                )
        }
        .frame(height: 40)
    }
}

#Preview {
    TableHeader(isOld: false)
}
