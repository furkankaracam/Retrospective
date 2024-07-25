//
//  PaginationView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct PaginationView: View {
    @Binding var selectedPage: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<4) { index in
                if index > 0 {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.blue)
                }
                Circle()
                    .stroke(selectedPage == index ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Circle().fill(selectedPage == index ? Color.blue : Color.clear))
                    .frame(width: 20, height: 20)
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2.5, height: 20)
        .padding()
    }
}

#Preview {
    PaginationView(selectedPage: .constant(1))
}
