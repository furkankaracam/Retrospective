//
//  SessionDetail.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import SwiftUI

struct SessionDetail: View {
    @StateObject private var viewModel = SessionDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ColumnCard(title: "Neleri İyi yaptık?", cards: [
                    Card(id: 1, createdBy: "Ahmet", text: "İşlemler çok güzeldi"),
                    Card(id: 2, createdBy: "Furkan Karaçam", text: "Süper")
                ])
                
                ColumnCard(title: "Geliştirilebilir yönlerimiz nelerdi?", cards: [
                    Card(id: 1, createdBy: "Veli", text: "Daha iyi yapılabilirdi"),
                    Card(id: 2, createdBy: "Ali", text: "İletişim daha iyi olabilirdi, yazıyı daha uzun tutarsak ne mi olur?")
                ])
            }
            .padding()
        }
    }
}

#Preview {
    SessionDetail()
}
