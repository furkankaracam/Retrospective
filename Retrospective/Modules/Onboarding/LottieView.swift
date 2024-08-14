//
//  LottieView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 14.08.2024.
//

import SwiftUI
import DotLottie

struct LottieView: View {
    var fileName: String
    var body: some View {
        DotLottieAnimation(fileName: fileName, config: AnimationConfig(autoplay: true, loop: true)).view()
    }
}

#Preview {
    LottieView(fileName: "lottie1")
}
