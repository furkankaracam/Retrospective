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
    @State private var showingCommentInput: String?
    
    @State var sessionId: String
    @State var timer: Int
    @State var sessionName: String

    var body: some View {
        VStack {
            HStack {
                Text(sessionName)
                    .font(.title)
                Spacer()
                HStack(content: {
                    Image("timer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text("\(viewModel.time ?? "00:00")")
                        .bold()
                })
            }
            .padding(.horizontal)
            
            List {
                ForEach($viewModel.items, id: \.id, editActions: [.move, .delete]) { $item in
                    
                    if !item.isComment {
                        ColumnTitle(title: item.column?.name ?? "")
                            .moveDisabled(true)
                            .deleteDisabled(true)
                        
                        if showingCommentInput == item.column?.id {
                            TextField("Yeni yorumunuzu yazın", text: $newComment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            HStack {
                                Button("Vazgeç") {
                                    showingCommentInput = nil
                                    newComment = ""
                                }
                                .tint(.red)
                                
                                Button("Yorum Gönder") {
                                    Task {
                                        if !newComment.isEmpty {
                                            await viewModel.addComment(sessionId: sessionId, to: item.column?.id ?? "", comment: newComment)
                                            newComment = ""
                                            showingCommentInput = nil
                                        }
                                    }
                                }
                                .buttonStyle(.bordered)
                                .padding()
                            }
                        }
                        
                        Button("Yeni Ekle") {
                            if showingCommentInput == item.column?.id {
                                showingCommentInput = nil
                                newComment = ""
                            } else {
                                showingCommentInput = item.column?.id
                            }
                        }
                        .padding()
                        
                        Rectangle()
                            .frame(height: 20)
                            .listRowInsets(.init())
                            .padding(0)
                            .deleteDisabled(true)
                            .hidden()
                        
                    } else {
                        CommentCard(viewModel: viewModel, isEditing: .constant(false), isAnonym: viewModel.anonymStatus ?? false, card: item.comment ?? Comment(id: nil, author: nil, comment: nil, order: item.comment?.order))
                    }
                }
                .onMove(perform: moveItems)
                .onDelete { indexSet in
                    for index in indexSet {
                        deleteItem(at: index)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .listStyle(.plain)
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
    }

    private func findColumnId(forCommentAt index: Int) -> String? {
        guard index >= 0 else { return nil }
        
        var columnId: String?
        
        for index in (0..<index).reversed() {
            let item = viewModel.items[safe: index]
            if let item = item, !item.isComment, let id = item.column?.id {
                columnId = id
                break
            }
        }
        
        return columnId
    }
    
    private func moveItems(fromOffsets source: IndexSet, toOffset destination: Int) {
        var newItems: [ListItem] = viewModel.items

        let movedItem = newItems.remove(at: source.first ?? 0)
        // Burda fatal yedim
        newItems.insert(movedItem, at: destination)

        let oldColumnId = findColumnId(forCommentAt: source.first ?? 0)
        let newColumnId = findColumnId(forCommentAt: destination)
        
        Task {
            if oldColumnId != newColumnId {
                if let movedComment = movedItem.comment {
                    await viewModel.deleteComment(sessionId: viewModel.sessionKey, columnId: oldColumnId ?? "", commentId: movedComment.id ?? "")
                    await viewModel.addComment(sessionId: viewModel.sessionKey, to: newColumnId ?? "", comment: movedComment.comment ?? "")
                }
            }
            await viewModel.updateOrderInColumn(columnId: oldColumnId ?? "", items: newItems.filter { $0.column?.id == oldColumnId })
            await viewModel.updateOrderInColumn(columnId: newColumnId ?? "", items: newItems.filter { $0.column?.id == newColumnId })
        }
        
        viewModel.items = newItems
    }

    private func deleteItem(at index: Int) {
        let item = viewModel.items[index]
        
        if item.isComment, let commentId = item.comment?.id {
            if let columnId = findColumnId(forCommentAt: index) {
                Task {
                    await viewModel.deleteComment(sessionId: viewModel.sessionKey, columnId: columnId, commentId: commentId)
                }
            } else {
                print("Column ID for comment \(commentId) not found")
            }
        }
    }
}

#Preview {
    SessionDetail(sessionId: "-O3XEnBJtrBjIc4O1m-x", timer: 60, sessionName: "Sezon")
}
