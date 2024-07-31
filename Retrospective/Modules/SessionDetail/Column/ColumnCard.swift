//
//  ColumnCard.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct ColumnCard: View {
    var title: String
    var cards: [Card]
    
    var body: some View {
        Section(header: ColumnTitle(title: title)) {
            ColumnBody(cards: cards)
        }
    }
}

#Preview {
    ColumnCard(title: "Başlık", cards: [Card(id: 1, createdBy: "Cardd", text: "Deneme"),  Card(id: 2, createdBy: "Cardd", text: "Deneme 2")])
}
