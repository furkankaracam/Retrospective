//
//  Card.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct CommentCard: View {
    @StateObject private var viewModel: SessionDetailViewModel = SessionDetailViewModel()
    
    var card: Card
    var body: some View {
        HStack {
            Text(card.text)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
            Spacer()
            Text(card.createdBy)
                .font(.caption)
            
            Image(systemName: "line.3.horizontal")
                .padding()
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation {
                                viewModel.offsets[card.id ?? 0] = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                viewModel.offsets[card.id ?? 0] = value.translation
                            }
                        }
                )
        }
        .offset(viewModel.offsets[card.id ?? 0] ?? .zero)
        .padding()
    }
}

#Preview {
    CommentCard(card: Card(id: 1, createdBy: "Furkan", text: "Deneme"))
}
