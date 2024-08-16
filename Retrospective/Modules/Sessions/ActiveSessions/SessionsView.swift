//
//  HomeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import SwiftUI

struct SessionsView: View {
    
    @StateObject var viewModel = SessionViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                PageHeader(image: "sessions", pageName: "Aktif oturumlar")
                TableHeader(isOld: false)
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.sessions.isEmpty {
                        CustomEmptyTableView()
                    } else {
                        SessionsTable(sessions: viewModel.sessions, viewModel: viewModel)
                    }
                }
                Spacer()
            }
            .task {
                await viewModel.fetchData(type: .session)
            }
        }
    }
}

#Preview {
    SessionsView()
}
