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
                    Text("\(viewModel.time ?? "00:00")")
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
                                CommentCard(viewModel: viewModel, isEditing: .constant(false), isAnonym: viewModel.anonymStatus ?? false, card: comment)
                            }.onDelete { indexSet in
                                let columnId = column.id ?? ""
                                indexSet.forEach { index in
                                    let commentId = Array(comments.keys)[index]
                                    Task {
                                        await viewModel.deleteComment(sessionId: viewModel.sessionKey, columnId: columnId, commentId: commentId)
                                    }
                                }
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
                viewModel.startTimer(id: sessionId)
            }
        }
        .onDisappear {
            viewModel.timer?.invalidate()
            NotificationCenter.default.post(name: .sessionDetailDidDisappear, object: nil)
        }
        .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        .listStyle(.plain)
    }
}

extension Notification.Name {
    static let sessionDetailDidDisappear = Notification.Name("sessionDetailDidDisappear")
}

#Preview {
    SessionDetail(sessionId: "-O3XEnBJtrBjIc4O1m-x", timer: 60, sessionName: "Sezon")
}
