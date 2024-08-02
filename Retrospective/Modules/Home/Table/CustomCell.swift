//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    
    let session: Session
    @State private var isNavigationActive = false

    var body: some View {
        GeometryReader { geo in
            HStack {
                Text(session.name)
                Spacer()
                Text(session.isActive ? "Aktif" : "Pasif")
                    .foregroundColor(session.isActive ? .blue : .gray)
                Spacer()
                if session.isActive {
                    Button(action: {
                        isNavigationActive = true
                    }) {
                        Image(systemName: "eye")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .clipShape(Circle())
                            .contentShape(Circle())
                    }
                    .background(
                        NavigationLink(destination: SessionDetail(), isActive: $isNavigationActive) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }
                if !session.isActive {
                    Button(action: {
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    CustomCell(session: Session(id: nil, columns: [:], createdBy: "Furkan", isActive: true, name: "Deneme", participants: ["Furkan": 1], settings: Settings(anonymous: false, authorVisibility: false, time: 4, password: "Password")))
}
