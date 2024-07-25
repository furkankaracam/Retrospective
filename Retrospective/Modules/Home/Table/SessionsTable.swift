//
//  SessionsTable.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SessionsTable: View {
    var sessions: [Session]
    var body: some View {
        List {
            ForEach(sessions) { session in
                CustomCell(session: session)
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    SessionsTable(sessions: [Session(id: 1, name: "Deneme", isActive: true, isEditable: true, isShowable: true, isDeletable: true)])
}
