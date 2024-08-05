//
//  SessionDetail.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct SessionDetail: View {
    @StateObject private var viewModel = SessionDetailViewModel()
    @State private var isEditing: Bool = false
    @State private var newComment: String = ""
    @State private var showingCommentInput: String? = nil
    
    var body: some View {
        List {
            ForEach($viewModel.columns, id: \.comments.values.first?.comment, editActions: .move) { $column in
                ColumnTitle(title: column.name)
                ForEach(Array(column.comments.values), id: \.comment) { comment in
                    CommentCard(isEditing: .constant(false), card: Comment(id: comment.id, author: comment.author, comment: comment.comment))
                }
                if showingCommentInput == column.comments.keys.first {
                    TextField("Yeni yorumunuzu yazın", text: $newComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                }
                HStack {
                    if showingCommentInput != column.comments.keys.first {
                        Button("Yeni Ekle") {
                            showingCommentInput = column.comments.keys.first
                            if newComment != "" {
                                newComment = ""
                            }
                        }
                    } else {
                        Button("Vazgeç") {
                            showingCommentInput = nil
                            newComment = ""
                        }
                        .tint(.red)
                    }
                    
                    if !newComment.isEmpty {
                        Button("Yorum Gönder") {
                            if !newComment.isEmpty {
                                // viewModel.addComment(to: column, comment: newComment)
                                newComment = ""
                                showingCommentInput = nil
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .task {
            await viewModel.fetchColumns(id: "-O3WegpxcEYxF6zk4M_z")
        }
        .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        .listStyle(.plain)
    }
}

#Preview {
    SessionDetail()
}
