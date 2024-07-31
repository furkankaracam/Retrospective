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
    @Published var columns: [String] = []
    @Published var createdBy: String = ""
    @Published var isActive: Bool = true
    @Published var name: String = ""
    @Published var participants: [String: Int] = ["Kullanıcım":4]
    @Published var settings: Settings = Settings()
    
    struct Settings {
        var anonymous, authorVisibility: Bool
        var time: Int
        var password: String
        
        init(anonymous: Bool = false, authorVisibility: Bool = true, time: Int = 0, password: String = "") {
            self.anonymous = anonymous
            self.authorVisibility = anonymous
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
    
    func toDictionary() -> [String: Any] {
        return [
            "columns": columns,
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
    
    @StateObject private var newSession = SessionData()
    
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
                    }.environmentObject(newSession)
                
                SessionDetail()
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
