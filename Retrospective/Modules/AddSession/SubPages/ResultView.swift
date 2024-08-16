//
//  ResultView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ResultView: View {
    @Binding var selectedTab: Tabs
    @ObservedObject var viewModel: AddSessionViewModel
    @State private var qrCodeImage: UIImage?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Tebrikler! Oturum başarıyla oluşturuldu.")
                .font(.title2)
            
            if let qrCodeImage = qrCodeImage {
                Image(uiImage: qrCodeImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            Button("Oturumları Gör") {
                selectedTab = .sessions
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
        .padding()
        .onAppear {
            qrCodeImage = viewModel.generateQRCode(from: viewModel.createDeepLinkURL(sessionID: viewModel.session.name)?.absoluteString ?? "")
        }
    }
    
    
}
