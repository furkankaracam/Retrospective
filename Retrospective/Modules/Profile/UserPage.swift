//
//  UserPage.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 16.08.2024.
//

import SwiftUI

struct UserPage: View {
    @StateObject private var authManager = AuthManager()
    
    var body: some View {
        if authManager.authState == .signedIn {
            ProfileView(authManager: authManager)
        } else {
            SignUpView(authManager: authManager)
        }
    }
    
}

#Preview {
    UserPage()
}
