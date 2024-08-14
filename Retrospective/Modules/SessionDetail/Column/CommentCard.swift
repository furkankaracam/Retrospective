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
        Rectangle()
            .fill(Color.blue)
            .cornerRadius(15)
            .overlay(
                HStack {
                    if let comment = card.comment {
                        Text(comment)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    
                    if isAnonym {
                        if let author = card.author {
                            Text(author)
                                .font(.caption)
                                .tint(.white)
                        }
                    }
                    
                    Image(systemName: "line.3.horizontal")
                        .padding()
                        .onLongPressGesture {
                            isEditing = true
                        }
                }
                    .padding(.horizontal)
            )
            .foregroundColor(.white)
            .frame(height: 50)
    }
}

#Preview {
    CommentCard(viewModel: SessionDetailViewModel(), isEditing: .constant(false), isAnonym: true, card: Comment(id: "1", author: "Furkan", comment: "Yorum", order: 3))
}
