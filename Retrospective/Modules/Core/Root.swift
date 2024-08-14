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
}

@main
struct RetrospectiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    @StateObject private var authManager = AuthManager()
    @State private var selectedTab: Tabs = .sessions
    
    var body: some Scene {
        WindowGroup {
            if hasOnboarded {
                TabView(selection: $selectedTab) {
                    SessionsView()
                        .tabItem {
                            Label("Oturumlar", systemImage: "list.dash")
                        }
                        .tag(Tabs.sessions)
                    
                    OldSessionView()
                        .tabItem {
                            Label("Geçmiş Oturumlar", systemImage: "clock")
                        }
                        .tag(Tabs.oldSessions)
                    
                    AddSessionView(selectedTab: $selectedTab)
                        .tabItem {
                            Label("Oturum Ekle", systemImage: "plus")
                        }
                        .tag(Tabs.addSession)
                    SignUpView(authManager: authManager)
                        .tabItem {
                            Label("Profil", systemImage: "person")
                        }
                        .tag(Tabs.profile)
                }
            } else {
                OnboardingView()
            }
            
        }
    }
}
