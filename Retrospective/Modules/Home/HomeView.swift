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
                Text("Geçmiş Oturumlar")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.main.bounds.width)
                if viewModel.oldSessions.isEmpty {
                    CustomEmptyTableView()
                } else {
                    SessionsTable(sessions: viewModel.oldSessions)
                }
                
            }
            .navigationTitle("Oturumlar")
            .task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    HomeView()
}
