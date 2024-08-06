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
    @State var sessionName: String
    
    var body: some View {
        VStack {
            HStack(alignment: .center, content: {
                Text(sessionName)
                    .font(.title)
                Spacer()
                HStack(content: {
                    Text("Kalan Süre:")
                    Text("\(viewModel.time ?? 0)")
                        .bold()
                })
            })
            .padding(.horizontal)
            
            List {
                ForEach($viewModel.columns, id: \.id, editActions: [.move, .delete]) { $column in
                    
                    if let columnName = column.name {
                        ColumnTitle(title: columnName)
                            .moveDisabled(true)
                            .deleteDisabled(true)
                    }
                    
                    if let comments = column.comments {
                        if comments.count > 0 {
                            ForEach(Array(comments.values), id: \.id) { comment in
                                CommentCard(isEditing: .constant(false), card: Comment(id: comment.id, author: comment.author, comment: comment.comment))
                            }.onDelete(perform: { indexSet in
                                print("Silinecek eleman \(indexSet.first)")
                                //viewModel.deleteComment(index: indexSet)
                            })
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
                viewModel.startTimer(id: sessionId)
                await viewModel.fetchColumns(id: sessionId)
            }
        }
        .onDisappear(perform: {
            viewModel.timer?.invalidate()
        })
        .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        .listStyle(.plain)
    }
}

#Preview {
    SessionDetail(sessionId: "-O3XEnBJtrBjIc4O1m-x", sessionName: "Sezon")
}
