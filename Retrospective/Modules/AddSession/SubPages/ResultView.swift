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
        VStack(alignment: .leading) {
            Text("Tebrikler! Oturum başarıyla oluşturuldu.")
            Button("Oturumları Gör") {
                selectedTab = .sessions
            }
        }
    }
}

#Preview {
    ResultView(selectedTab: .constant(.sessions))
}
