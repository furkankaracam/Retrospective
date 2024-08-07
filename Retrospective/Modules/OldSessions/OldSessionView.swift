//
//  OldSessionView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct OldSessionView: View {
    
    @StateObject var viewModel = OldSessionsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TableHeader()
                if viewModel.oldSessions.isEmpty {
                    CustomEmptyTableView()
                } else {
                    SessionsTable(sessions: viewModel.oldSessions)
                }                
            }
            .navigationTitle("Geçmiş Oturumlar")
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    OldSessionView()
}
