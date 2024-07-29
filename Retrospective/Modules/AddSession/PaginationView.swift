//
//  PaginationView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct PaginationView: View {
    @Binding var selectedPage: AddSessionPages
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AddSessionPages.allCases, id: \.self) { page in
                if page != AddSessionPages.allCases.first {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.blue)
                }
                Circle()
                    .stroke(selectedPage == page ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Circle().fill(selectedPage == page ? Color.blue : Color.clear))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        selectedPage = page
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2.5, height: 20)
        .padding()
    }
}

#Preview {
    PaginationView(selectedPage: .constant(.name))
}
