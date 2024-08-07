//
//  HomeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TableHeader()
                if viewModel.sessions.isEmpty {
                    CustomEmptyTableView()
                } else {
                    SessionsTable(sessions: viewModel.sessions)
                }
            }
            .navigationTitle("Aktif Oturumlar")
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    HomeView()
}
