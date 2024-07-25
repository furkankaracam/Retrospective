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
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Oturumlar", systemImage: "list.dash")
                    }
                
                AddSessionView()
                    .tabItem {
                        Label("Oturum Ekle", systemImage: "plus")
                    }
                
                EmptyView()
                    .tabItem {
                        Label("Profil", systemImage: "person")
                    }
            }
        }
    }
}

struct EmptyView: View {
    var body: some View {
        Text("Boş Sayfa")
    }
}
