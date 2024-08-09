//
//  Card.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct CommentCard: View {
    
    @StateObject var viewModel: SessionDetailViewModel
    @Binding var isEditing: Bool
    @State var isAnonym: Bool
    
    var card: Comment
    
    var body: some View {
        HStack {
            if let comment = card.comment {
                Text(comment)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical)
            }
            Spacer()
            
            if !isAnonym {
                if let author = card.author {
                    Text(author)
                        .font(.caption)
                }
            }
            
            Image(systemName: "line.3.horizontal")
                .padding()
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
                .onLongPressGesture {
                    print("Uzun basıldı")
                    isEditing = true
                    print(isEditing)
                }
        }
        .padding()
    }
}

#Preview {
    CommentCard(viewModel: SessionDetailViewModel(), isEditing: .constant(false), isAnonym: true, card: Comment(id: "1", author: "Furkan", comment: "Yorum"))
}
