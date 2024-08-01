//
//  SessionDetail.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct SessionSection: Identifiable {
    var id: Int
    var title: String
    var comments: [Card]
}

struct SessionDetail: View {
    @StateObject private var viewModel = SessionDetailViewModel()
    @State var content = [
        SessionSection(id: 1, title: "Neleri iyi yaptık", comments: [
            Card(id: 1, createdBy: "Furkan", text: "Yapı iyiydi"),
            Card(id: 2, createdBy: "Ali", text: "Her şey iyiydi")
        ]),
        SessionSection(id: 2, title: "Neleri kötü yaptık", comments: [
            Card(id: 3, createdBy: "Yunus", text: "Yapı kötüydü"),
            Card(id: 4, createdBy: "Kaan", text: "Önce yapı")
        ])
    ]
    @State var isEditable: Bool
    
    var body: some View {
        List($content, editActions: .move) {section in
            Section(header: ColumnTitle(title: "\(section.title.wrappedValue)")) {
                ForEach(section.comments, id: \.id) { comment in
                    CommentCard(isEditable: .constant(false), card: comment.wrappedValue)
                }
            }
        }
        .toolbar {
            EditButton()
        }
        .onAppear(perform: {
            
        })
        
    }
}

#Preview {
    SessionDetail( isEditable: false)
}
