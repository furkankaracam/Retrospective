//
//  RetrospectiveApp.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("açıldı")
        return true
    }
}



@main
struct RetrospectiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    @StateObject private var authManager = AuthManager()
    @State private var selectedTab: Tabs = .sessions
    @State private var isConnected: Bool = true
    @State private var showAlert: Bool = false
    @State private var deepLinkSessionId: String?

    var body: some Scene {
        WindowGroup {
            if isConnected {
                if hasOnboarded {
                    TabView(selection: $selectedTab) {
                        SessionsView()
                            .tabItem {
                                Label("Oturumlar", systemImage: "list.dash")
                            }
                            .tag(Tabs.sessions)
                            .onAppear {
                                checkInternetConnection()
                            }
                        
                        OldSessionView()
                            .tabItem {
                                Label("Geçmiş Oturumlar", systemImage: "clock")
                            }
                            .tag(Tabs.oldSessions)
                            .onAppear {
                                checkInternetConnection()
                            }
                        
                        AddSessionView(selectedTab: $selectedTab)
                            .tabItem {
                                Label("Oturum Ekle", systemImage: "plus")
                            }
                            .tag(Tabs.addSession)
                            .onAppear {
                                checkInternetConnection()
                            }
                        
                        UserPage()
                            .tabItem {
                                Label("Profil", systemImage: "person")
                            }
                            .tag(Tabs.profile)
                            .onAppear {
                                checkInternetConnection()
                            }
                    }
                } else {
                    OnboardingView()
                        .onAppear {
                            checkInternetConnection()
                        }
                }
            } else {
                VStack {
                    Text("İnternet bağlantısı yok.")
                    Button("Tekrar Dene") {
                        checkInternetConnection()
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
    }
    
    private func handleIncomingURL(url: URL) {
        print("Received URL: \(url)")
        if url.scheme == "retrospective", let host = url.host {
            deepLinkSessionId = host
            print("Deep link session ID: \(host)")
        } else {
            print("Invalid URL scheme or host")
        }
    }

    func checkInternetConnection() {
        isConnected = Reachability.isConnectedToNetwork()
    }
}

