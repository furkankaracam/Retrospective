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
    @State private var showingCommentInput: String? = ""
    
    @State var sessionId: String
    @State var timer: Int
    @State var sessionName: String
    
    var body: some View {
        VStack {
            HStack(alignment: .center, content: {
                Text(sessionName)
                    .font(.title)
                Spacer()
                HStack(content: {
                    Text("Kalan Süre:")
                    Text("\(timer)")
                        .bold()
                })
            })
            .padding(.horizontal)
            
            List {
                ForEach($viewModel.columns, id: \.id, editActions: .move) { $column in
                    
                    if let columnName = column.name {
                        ColumnTitle(title: columnName)
                            .moveDisabled(true)
                    }
                    
                    if let comments = column.comments {
                        if comments.count > 0 {
                            ForEach(Array(comments.values), id: \.id) { comment in
                                CommentCard(isEditing: .constant(false), card: Comment(id: comment.id, author: comment.author, comment: comment.comment))
                            }
                        }
                    }
                    
                    if showingCommentInput == column.id {
                        TextField("Yeni yorumunuzu yazın", text: $newComment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    HStack {
                        if showingCommentInput != column.id {
                            Button("Yeni Ekle") {
                                showingCommentInput = column.id
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
                                Task {
                                    if !newComment.isEmpty {
                                        await viewModel.addComment(sessionId: sessionId, to: column.id ?? "", comment: newComment)
                                        newComment = ""
                                        showingCommentInput = nil
                                    }
                                }
                            }
                            .buttonStyle(.bordered)
                            .padding()
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .task {
            if !sessionId.isEmpty {
                await viewModel.fetchColumns(id: sessionId)
            }
        }
        .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        .listStyle(.plain)
    }
}

#Preview {
    SessionDetail(sessionId: "-O3XEnBJtrBjIc4O1m-x", timer: 60, sessionName: "Sezon")
}
