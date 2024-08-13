//
//  EmptyView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 26.07.2024.
//

import SwiftUI

struct CustomEmptyTableView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: .remove)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                .frame(width: UIScreen.main.bounds.width - 100, height: 70)
                .padding()
            Text("Veri yok!")
        }
    }
}

#Preview {
    CustomEmptyTableView()
}
