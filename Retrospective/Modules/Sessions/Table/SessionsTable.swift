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
    @State private var selectedSession: RetroSession?
    @State private var showingPasswordView = false

    var body: some View {
        List {
            ForEach(sessions, id: \.id) { session in
                Button(action: {
                    selectedSession = session
                    showingPasswordView = true
                }) {
                    CustomCell(session: session, viewModel: viewModel, isOld: !(session.isActive ?? false))
                }
                .sheet(isPresented: $showingPasswordView) {
                    if let selectedSession = selectedSession {
                        PasswordView(session: selectedSession)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SessionsTable(sessions: [], viewModel: SessionViewModel())
}

