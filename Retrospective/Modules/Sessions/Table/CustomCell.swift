//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    let session: RetroSession
    @StateObject var viewModel: SessionViewModel
    @State private var isNavigationActive = false
    @State private var showPasswordSheet = false
    @State private var isAuthenticated = false
    
    var isOld: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                    .overlay(
                        HStack {
                            if let sessionName = session.name {
                                Text(sessionName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            if !isOld {
                                Text(TimeFormatterUtility.formatTime(seconds: session.settings?.time ?? 0))
                                    .frame(width: UIScreen.main.bounds.size.width / (isOld ? 2 : 3))
                            }
                            
                            if let sessionActiveStatus = session.isActive {
                                Group {
                                    HStack {
                                        if sessionActiveStatus {
                                            Button(action: {
                                                showPasswordSheet = true
                                            }) {
                                                Image(systemName: "eye")
                                                    .padding()
                                                    .background(
                                                        NavigationLink(destination: SessionDetail(sessionId: session.id ?? "", timer: 1, sessionName: session.name ?? ""), isActive: $isNavigationActive) {
                                                        }
                                                            .hidden()
                                                    )
                                            }
                                        }
                                        if !sessionActiveStatus {
                                            Button(action: {
                                            }) {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                                    .padding(.trailing)
                                }
                                .frame(width: UIScreen.main.bounds.size.width / 3)
                            }
                        }
                            .padding(.horizontal)
                    )
            )
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width, height: 50)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            .sheet(isPresented: $showPasswordSheet) {
                PasswordView(isPresented: $showPasswordSheet, isAuthenticated: $isAuthenticated, correctPassword: session.settings?.password ?? "")
                    .environmentObject(viewModel)
            }
            .onChange(of: viewModel.isAuthenticated) { newValue in
                DispatchQueue.main.async {
                    if newValue {
                        isNavigationActive = true
                    }
                }
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: .sessionDetailDidDisappear, object: nil, queue: .main) { _ in
                    isNavigationActive = false
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: .sessionDetailDidDisappear, object: nil)
            }
    }
}
