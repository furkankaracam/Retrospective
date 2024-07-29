//
//  AddSession.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

enum AddSessionPages: CaseIterable {
    case name
    case time
    case columns
    case result
}

struct AddSessionView: View {
    @Binding var pageIndex: AddSessionPages
    @StateObject var viewModel = AddSessionViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch pageIndex {
                case .name:
                    PaginationView(selectedPage: .constant(.name))
                    SelectNameView()
                case .time:
                    PaginationView(selectedPage: .constant(.time))
                    SelectTimeView()
                case .columns:
                    PaginationView(selectedPage: .constant(.columns))
                    SelectColumnsView()
                case .result:
                    PaginationView(selectedPage: .constant(.result))
                    ResultView()
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    AddSessionView(pageIndex: .constant(.name), viewModel: AddSessionViewModel())
}
