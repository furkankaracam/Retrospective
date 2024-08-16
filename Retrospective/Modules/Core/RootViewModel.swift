//
//  RootViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 16.08.2024.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var selectedTab: Tabs = .sessions
    @Published var isConnected: Bool = true
    @Published var deepLinkSessionId: String?

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Internet connection
    func checkInternetConnection() {
        isConnected = Reachability.isConnectedToNetwork()
    }
    
    // MARK: - Deep link handling
    func handleIncomingURL(url: URL) {
        print("Received URL: \(url)")
        if url.scheme == "retrospective", let host = url.host {
            deepLinkSessionId = host
            print("Deep link session ID: \(host)")
        } else {
            print("Invalid URL scheme or host")
        }
    }
}
