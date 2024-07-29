//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    
    let session: Session
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text(session.name)
                Spacer()
                Text(session.isActive ? "Aktif" : "Pasif")
                    .foregroundColor((session.isActive) ? .blue : .gray)
                Spacer()
                if session.isActive {
                    Button(action: {
                    }, label: {
                        Image(systemName: "eye")
                    })
                }
                if !session.isActive {
                    Button(action: {
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    CustomCell(session: Session(id: 1, createdBy: "2022", name: "Sezon", password: "Password", participants: [
        "userId1": 1,
        "userId2": 1
    ], settings: Settings(anonymous: false, timer: 5), columns: [
        "column1": Column(
            id: 1, name: "To Do",
            cards: [
                "card1": Card(
                    id: 1, createdBy: "userId1",
                    text: "Task 1",
                    timestamp: 1627890123456
                ),
                "card2": Card(
                    id: 1, createdBy: "userId2",
                    text: "Task 2",
                    timestamp: 1627890123457
                )
            ]
        ),
        "column2": Column(
            id: 1, name: "In Progress",
            cards: [
                "card3": Card(
                    id: 1, createdBy: "userId1",
                    text: "Task 3",
                    timestamp: 1627890123458
                )
            ]
        ),
        "column3": Column(
            id: 1, name: "Done",
            cards: nil
        )
    ], isActive: false))
}
