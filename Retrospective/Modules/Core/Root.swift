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

final class SessionData: ObservableObject {
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var time: String = ""
    @Published var isHidden: Bool = false
    @Published var columns: [String] = []
}

@main
struct RetrospectiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var newSession = SessionData()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Oturumlar", systemImage: "list.dash")
                    }
                
                AddSessionView(pageIndex: .constant(.name))
                    .tabItem {
                        Label("Oturum Ekle", systemImage: "plus")
                    }.environmentObject(newSession)
                
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
