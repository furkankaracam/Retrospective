//
//  LoadingView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 13.08.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Yükleniyor...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5, anchor: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.05).edgesIgnoringSafeArea(.all))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    LoadingView()
}
