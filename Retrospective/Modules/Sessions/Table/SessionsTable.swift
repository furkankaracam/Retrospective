//
//  SessionsTable.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SessionsTable: View {
    
    var sessions: [RetroSession]
    @ObservedObject var viewModel: SessionViewModel
    
    var body: some View {
        List {
            ForEach(sessions, id: \.id) { session in
                CustomCell(session: session, viewModel: viewModel, isOld: !(session.isActive ?? false))
            }        .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SessionsTable(sessions: [], viewModel: SessionViewModel())
}
