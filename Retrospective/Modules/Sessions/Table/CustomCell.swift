//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    
    let session: RetroSession
    @ObservedObject var viewModel: SessionViewModel

    var isOld: Bool

    var body: some View {
        VStack {
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
                                    Button(action: {
                                        
                                    }) {
                                        Image(systemName: "eye")
                                            .padding()
                                    }
                                    
                                    if !sessionActiveStatus {
                                        Button(action: {
                                            // Handle delete action
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
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width, height: 50)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
        .background(
            
        )
        .sheet(isPresented: .constant(false)) {
            PasswordView(session: session)
                .environmentObject(viewModel)
        }
    }
}
