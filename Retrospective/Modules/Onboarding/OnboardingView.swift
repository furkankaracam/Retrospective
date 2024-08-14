//
//  OnboardingView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 14.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<viewModel.onboardingItems.count) { index in
                let item = viewModel.onboardingItems[index]
                OnboardingPageView(
                    title: item.title,
                    description: item.description,
                    lottieName: item.lottieName,
                    isLastPage: index == viewModel.onboardingItems.count - 1
                )
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .overlay(
            VStack {
                Spacer()
                
                if currentPage == viewModel.onboardingItems.count - 1 {
                    Button(action: {
                        hasOnboarded = true
                    }) {
                        Text("Hadi Başlayalım!")
                            .font(.title2)
                            .bold()
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
                .padding()
        )
    }
}

#Preview {
    OnboardingView()
}
