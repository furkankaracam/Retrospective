//
//  SignInView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import SwiftUI

struct SignInView: View {
    
    @State var isPresented: Bool
    
    var body: some View {
        Button("Kapat") {
            isPresented = false
        }
    }
}

#Preview {
    SignInView(isPresented: false)
}
