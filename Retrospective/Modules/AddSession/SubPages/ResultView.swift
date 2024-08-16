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
            qrCodeImage = generateQRCode(from: createDeepLinkURL(sessionID: viewModel.session.name ?? "")?.absoluteString ?? "")
        }
    }
    
    private func createDeepLinkURL(sessionID: String) -> URL? {
        return URL(string: "retrospective://")
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)
            
            let context = CIContext()
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}
