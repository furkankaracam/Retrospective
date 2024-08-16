//
//  ResultView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct ResultView: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tebrikler! Oturum başarıyla oluşturuldu.")
                .font(.title2)
            
            Button("Oturumları Gör") {
                selectedTab = .sessions
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
        .padding()
    }
}

#Preview {
    ResultView(selectedTab: .constant(.sessions))
}
