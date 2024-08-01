//
//  Card.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct CommentCard: View {
    @StateObject private var viewModel: SessionDetailViewModel = SessionDetailViewModel()
    @Binding var isEditable: Bool
    
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
                .onLongPressGesture {
                    print("Uzun basıldı")
                    print(isEditable)
                    isEditable = !isEditable
                    print(isEditable)
                }
        }
        .offset(viewModel.offsets[card.id ?? 0] ?? .zero)
        .padding()
        .onChange(of: isEditable) { oldValue, newValue in
            print("iseditable \(oldValue) idi \(newValue) oldu")
        }
        
    }
}

#Preview {
    CommentCard(isEditable: .constant(false), card: Card(id: 1, createdBy: "Furkan", text: "Deneme"))
}
