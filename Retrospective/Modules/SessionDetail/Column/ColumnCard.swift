//
//  ColumnCard.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct ColumnCard: View {
    var title: String
    var cards: [Comment]
    
    var body: some View {
        Section(header: ColumnTitle(title: title)) {
            ColumnBody(cards: cards)
        }
    }
}

#Preview {
    ColumnCard(title: "Başlık", cards: [Comment(id: "1", author: "Furkan", comment: "Yorum")])
}
