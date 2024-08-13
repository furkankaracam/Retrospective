//
//  PageHeader.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 13.08.2024.
//

import SwiftUI

struct PageHeader: View {
    
    var image: String
    var pageName: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
            Text(pageName)
                .bold()
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    PageHeader(image: "", pageName: "")
}
