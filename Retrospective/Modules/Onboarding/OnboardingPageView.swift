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
        VStack (spacing: 10) {
            LottieView(fileName: "swipe")
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            LottieView(fileName: lottieName)
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Group {
                Text(title)
                    .font(.title)
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
