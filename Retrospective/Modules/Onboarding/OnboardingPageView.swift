//
//  OnboardingView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 14.08.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    let title: String
    let description: String
    let lottieName: String
    
    var body: some View {
        VStack {
            LottieView(fileName: lottieName)
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            Group {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Text(description)
                    .font(.body)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}

#Preview {
    OnboardingPageView(title: "Hoşgeldiniz", description: "Açıklama", lottieName: "lottie1")
}
