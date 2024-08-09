//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    let session: RetroSession
    @State private var isNavigationActive = false
    @State private var showPasswordSheet = false
    @State private var isAuthenticated = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                if let sessionName = session.name {
                    Text(sessionName)
                        .frame(width: UIScreen.main.bounds.size.width / 3)
                }
                if let sessionActiveStatus = session.isActive {
                    Text(sessionActiveStatus ? "Aktif" : "Pasif")
                        .foregroundColor(sessionActiveStatus ? .blue : .gray)
                        .frame(width: UIScreen.main.bounds.size.width / 3)
                    Group {
                        if sessionActiveStatus {
                            Button(action: {
                                showPasswordSheet = true
                            }) {
                                Image(systemName: "eye")
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .clipShape(Circle())
                                    .contentShape(Circle())
                            }
                        }
                        if !sessionActiveStatus {
                            Button(action: {
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width / 3)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .sheet(isPresented: $showPasswordSheet) {
                PasswordView(isPresented: $showPasswordSheet, isAuthenticated: $isAuthenticated, correctPassword: session.settings?.password ?? "")
                
            }
            .onChange(of: isAuthenticated) { newValue in
                DispatchQueue.main.async {
                    if newValue {
                        isNavigationActive = true
                    }
                }
            }
            .background(
                NavigationLink(destination: SessionDetail(sessionId: session.id ?? "", timer: 1, sessionName: session.name ?? ""), isActive: $isNavigationActive) {
                    EmptyView()
                }
                    .hidden()
            )
        }
    }
}

#Preview {
    CustomCell(session: RetroSession(id: nil, columns: [:], createdBy: "Furkan", isActive: true, name: "Deneme", participants: ["Furkan": 1], settings: Settings(anonymous: false, authorVisibility: false, time: 4, password: "Password")))
}
