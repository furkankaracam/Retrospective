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
                        VStack(alignment: .leading) {
                            ColumnTitle(title: item.column?.name ?? "")
                                .moveDisabled(true)
                                .deleteDisabled(true)
                        }
                         
                        Rectangle()
                            .frame(height: 20)
                            .listRowInsets(.init())
                            .padding(0)
                            .deleteDisabled(true)
                            .hidden()
                    } else {
                        CommentCard(viewModel: viewModel, isEditing: .constant(false), isAnonym: viewModel.anonymStatus ?? false, card: item.comment ?? Comment(id: nil, author: nil, comment: nil, order: item.comment?.order))
                        
                        if item.isComment && item.id == viewModel.items.last(where: { $0.column?.id == item.column?.id })?.id {
                            
                            if showingCommentInput != item.column?.id {
                                Button("+ Yeni Ekle") {
                                    if showingCommentInput == item.column?.id {
                                        showingCommentInput = nil
                                        newComment = ""
                                    } else {
                                        showingCommentInput = item.column?.id
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .bold()
                                .cornerRadius(10)
                                .moveDisabled(true)
                                .deleteDisabled(true)
                            }
                            
                            if showingCommentInput == item.column?.id {
                                VStack {
                                    TextField("Yeni yorumunuzu yazın", text: $newComment)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .moveDisabled(true)
                                        .deleteDisabled(true)
                                    HStack {
                                        Button("Vazgeç") {
                                            showingCommentInput = nil
                                            newComment = ""
                                        }
                                        .tint(.red)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
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
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    }
                                    .moveDisabled(true)
                                    .deleteDisabled(true)
                                }
                            }
                        }
                        
                    }
                }
                .onMove(perform: { indices, newOffset in
                    viewModel.moveItems(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete { indexSet in
                    viewModel.deleteItem(at: indexSet.first ?? 0)
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
}

#Preview {
    SessionDetail(sessionId: "-O3XEnBJtrBjIc4O1m-x", timer: 60, sessionName: "Sezon")
}
