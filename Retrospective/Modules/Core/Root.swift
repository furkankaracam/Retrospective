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

import Foundation

final class SessionData: ObservableObject {
    @Published var columns: [String: Column] = [:]
    @Published var createdBy: String = ""
    @Published var isActive: Bool = true
    @Published var name: String = ""
    @Published var participants: [String: Int] = ["Kullanıcı adı": 4]
    @Published var settings: Settings = Settings()
    
    struct Settings {
        var anonymous: Bool
        var authorVisibility: Bool
        var time: Int
        var password: String
        
        init(anonymous: Bool = false, authorVisibility: Bool = true, time: Int = 0, password: String = "") {
            self.anonymous = anonymous
            self.authorVisibility = authorVisibility
            self.time = time
            self.password = password
        }
        
        func toDictionary() -> [String: Any] {
            return [
                "anonymous": anonymous,
                "authorVisibility": authorVisibility,
                "time": time,
                "password": password
            ]
        }
    }
    
    struct Column {
        
        var id: String?
        var name: String
        var comments: [String: Comment]
        
        func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "name": name,
                "comments": comments.mapValues { $0.toDictionary() }
            ]
        }
    }
    
    struct Comment {
        var id: String
        var author: String
        var comment: String
        
        func toDictionary() -> [String: Any] {
            return [
                "author": author,
                "comment": comment
            ]
        }
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": UUID().uuidString,
            "columns": columns.mapValues { $0.toDictionary() },
            "createdBy": createdBy,
            "isActive": isActive,
            "name": name,
            "participants": participants,
            "settings": settings.toDictionary()
        ]
    }
}

@main
struct RetrospectiveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authManager = AuthManager()
    @State private var selectedTab: Tabs?
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Oturumlar", systemImage: "list.dash")
                    }
                    .tag(Tabs.sessions)
                
                OldSessionView()
                    .tabItem {
                        Label("Geçmiş Oturumlar", systemImage: "clock")
                    }
                    .tag(Tabs.oldSessions)
                
                AddSessionView(selectedTab: .addSession)
                    .tabItem {
                        Label("Oturum Ekle", systemImage: "plus")
                    }
                    .tag(Tabs.addSession)
                
                ProfileView(authManager: authManager)
                    .tabItem {
                        Label("Profil", systemImage: "person")
                    }
                    .tag(Tabs.profile)
            }
            .onChange(of: selectedTab) { newValue in
                print("Selected tab changed to: \(newValue)")
            }
        }
    }
}
