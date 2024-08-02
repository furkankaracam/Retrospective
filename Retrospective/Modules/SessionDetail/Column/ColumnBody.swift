//
//  ColumnBody.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct ColumnBody: View {
    var cards: [Comment]

    var body: some View {
        ForEach(cards) { card in
            CommentCard(isEditing: .constant(false), card: Comment(id: "1", author: "Furkan", comment: "Deneme"))
        }
    }
}

#Preview {
    ColumnBody(cards: [Comment(id: "1", author: "Furkan", comment: "Yorum")])
}
