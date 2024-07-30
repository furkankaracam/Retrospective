//
//  AddSession.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//
import SwiftUI

struct AddSessionView: View {
    @StateObject private var viewModel = AddSessionViewModel()
    
    var body: some View {
        VStack {
            PaginationView(viewModel: viewModel)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Group {
                            SelectNameView()
                                .id(0)
                            SelectTimeView()
                                .id(1)
                            SelectColumnsView()
                                .id(2)
                            ResultView()
                                .id(3)
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                }
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
    }
}

#Preview {
    AddSessionView()
        .environmentObject(SessionData())
}
