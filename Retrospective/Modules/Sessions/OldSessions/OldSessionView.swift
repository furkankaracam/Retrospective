//
//  OldSessionView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct OldSessionView: View {
    
    @StateObject var viewModel = SessionViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                PageHeader(image: "sessions", pageName: "Geçmiş oturumlar")
                TableHeader(isOld: true)
                
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.sessions.isEmpty {
                        CustomEmptyTableView()
                    } else {
                        SessionsTable(sessions: viewModel.sessions, viewModel: viewModel)
                    }
                }
            }
            .task {
                await viewModel.fetchData(type: .oldSession)
            }
        }
    }
}

#Preview {
    OldSessionView()
}
