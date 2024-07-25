//
//  AddSession.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct AddSessionView: View {
    var body: some View {
        VStack {
            PaginationView(selectedPage: .constant(3))
            ResultView()
            Spacer()
        }
    }
}

#Preview {
    AddSessionView()
}
