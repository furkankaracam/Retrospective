//
//  Model.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 26.07.2024.
//

import Foundation

struct SessionResponse: Decodable {
    let sessions: [String: RetroSession]?
}

struct RetroSession: Identifiable, Decodable {
    let id: String?
    let columns: [String: Column]?
    let createdBy: String?
    let isActive: Bool?
    let name: String?
    let participants: [String: Int]?
    let settings: Settings?
}

struct Column: Identifiable, Decodable {
    let id: String?
    let name: String?
    var comments: [String: Comment]?
    var order: Int?
    
    init(id: String? = nil, name: String, comments: [String: Comment]? = nil, order: Int = 0) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.comments = comments
        self.order = order
    }
}

struct Comment: Identifiable, Decodable {
    let id: String?
    let author: String?
    let comment: String?
    var order: Int?
}

struct Settings: Decodable {
    let anonymous: Bool?
    let authorVisibility: Bool?
    let time: Int?
    let endTime: TimeInterval?
    let password: String?
}

struct ListItem {
    let id: String
    let isComment: Bool
    let comment: Comment?
    let column: Column?
}

final class SessionData: ObservableObject {
    @Published var columns: [String: Column] = [:]
    @Published var createdBy: String = ""
    @Published var isActive: Bool = true
    @Published var name: String = ""
    @Published var participants: [String: Int] = [:]
    @Published var settings: Settings = Settings()
    
    struct Settings {
        var anonymous: Bool
        var authorVisibility: Bool
        var time: Int
        var password: String
        var endTime: Date?
        
        init(anonymous: Bool = false, authorVisibility: Bool = true, time: Int = 15, password: String = "") {
            self.anonymous = anonymous
            self.authorVisibility = authorVisibility
            self.time = time
            self.password = password
        }
        
        func toDictionary() -> [String: Any] {
            return [
                "anonymous": anonymous,
                "authorVisibility": !authorVisibility,
                "time": time * 60,
                "password": password,
                "endTime": Date().addingTimeInterval(TimeInterval(time * 60)).timeIntervalSince1970
            ]
        }
    }
    
    struct Column {
        
        var id: String
        var name: String
        var comments: [String: Comment]
        var order: Int
        
        init(id: String = UUID().uuidString, name: String, comments: [String: Comment] = [:], order: Int = 0) {
            self.id = id
            self.name = name
            self.comments = comments
            self.order = order
        }
        
        func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "name": name,
                "comments": comments.mapValues { $0.toDictionary() },
                "order": order
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
