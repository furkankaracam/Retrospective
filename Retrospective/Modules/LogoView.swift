//
//  LogoView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 8.08.2024.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .cornerRadius(40)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.blue, lineWidth: 5))
            .shadow(color: .blue, radius: 10)
            .rotationEffect(.degrees(10))
            .padding()
    }
}

#Preview {
    LogoView()
}
