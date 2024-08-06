//
//  Model.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 26.07.2024.
//

import Foundation

struct SessionResponse: Decodable {
    let sessions: [String: Session]?
}

struct Session: Identifiable, Decodable {
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
    let comments: [String: Comment]?
}

struct Comment: Identifiable, Decodable {
    let id: String?
    let author: String?
    let comment: String?
}

struct Settings: Decodable {
    let anonymous: Bool?
    let authorVisibility: Bool?
    let time: Int?
    let password: String?
}
