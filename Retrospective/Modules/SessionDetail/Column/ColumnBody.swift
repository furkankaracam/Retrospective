//
//  ColumnBody.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct ColumnBody: View {
    var cards: [Card]

    var body: some View {
        ForEach(cards) { card in
            CommentCard(card: card)
        }
    }
}

#Preview {
    ColumnBody(cards: [Card(id: 1, createdBy: "Furkan", text: "İşlemler çok güzeldi"), Card(id: 2, createdBy: "Furkan 2", text: "Süper")])
}
