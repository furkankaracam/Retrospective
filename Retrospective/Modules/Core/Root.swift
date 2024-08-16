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
        return true
    }
}

@main
struct RetrospectiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    @StateObject private var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            if rootViewModel.isConnected {
                if hasOnboarded {
                    TabView(selection: $rootViewModel.selectedTab) {
                        SessionsView()
                            .tabItem {
                                Label("Oturumlar", systemImage: "list.dash")
                            }
                            .tag(Tabs.sessions)
                            .onAppear {
                                rootViewModel.checkInternetConnection()
                            }
                        
                        OldSessionView()
                            .tabItem {
                                Label("Geçmiş Oturumlar", systemImage: "clock")
                            }
                            .tag(Tabs.oldSessions)
                            .onAppear {
                                rootViewModel.checkInternetConnection()
                            }
                        
                        AddSessionView(selectedTab: $rootViewModel.selectedTab)
                            .tabItem {
                                Label("Oturum Ekle", systemImage: "plus")
                            }
                            .tag(Tabs.addSession)
                            .onAppear {
                                rootViewModel.checkInternetConnection()
                            }
                        
                        UserPage()
                            .tabItem {
                                Label("Profil", systemImage: "person")
                            }
                            .tag(Tabs.profile)
                            .onAppear {
                                rootViewModel.checkInternetConnection()
                            }
                    }
                } else {
                    OnboardingView()
                        .onAppear {
                            rootViewModel.checkInternetConnection()
                        }
                }
            } else {
                VStack {
                    Text("İnternet bağlantısı yok.")
                    Button("Tekrar Dene") {
                        rootViewModel.checkInternetConnection()
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
}
