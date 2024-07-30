//
//  PaginationView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct PaginationView: View {
    
    @ObservedObject var viewModel: AddSessionViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AddSessionPages.allCases, id: \.self) { page in
                if page != AddSessionPages.allCases.first {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.blue)
                }
                Circle()
                    .stroke(viewModel.pageIndex == page ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Circle().fill(viewModel.pageIndex == page ? Color.blue : Color.clear))
                    .frame(width: 20, height: 20)
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2.5, height: 20)
        .padding()
    }
}

#Preview {
    PaginationView(viewModel: AddSessionViewModel())
}
