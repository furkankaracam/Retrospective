//
//  AddSession.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct AddSessionView: View {
    
    @StateObject private var viewModel = AddSessionViewModel()
    @Binding var selectedTab : Tabs
    
    var body: some View {
        VStack(spacing: 10) {
            PageHeader(image: "sessions", pageName: "Oturum Ekle")
            PaginationView(viewModel: viewModel)
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Group {
                            SelectNameView(viewModel: viewModel)
                                .id(0)
                            SelectTimeView(viewModel: viewModel)
                                .id(1)
                            SelectColumnsView(viewModel: viewModel)
                                .id(2)
                            ResultView(selectedTab: $selectedTab, viewModel: viewModel)
                                .id(3)
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                }.scrollDisabled(true)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .onChange(of: viewModel.pageIndex) {
                        withAnimation {
                            proxy.scrollTo((AddSessionPages.allCases.firstIndex(of: viewModel.pageIndex)), anchor: .leading)
                        }
                    }
            }
            if viewModel.pageIndex != .result {
                NavigationButtons(viewModel: viewModel)
            }
        }
        .onDisappear(perform: {
            viewModel.columns = [:]
            viewModel.pageIndex = .name
            viewModel.session = SessionData()
        })
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    AddSessionView(selectedTab: .constant(.addSession))
}
