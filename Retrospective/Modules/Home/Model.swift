//
//  Model.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 26.07.2024.
//

struct SessionResponse: Decodable {
    let sessions: [String: Session]
}

struct Card: Identifiable, Decodable {
    let id: Int?
    let createdBy: String
    let text: String
    let timestamp: Int
}

struct Column: Identifiable, Decodable {
    let id: Int
    let name: String
    let cards: [String: Card]?
}

struct Session: Identifiable, Decodable {
    let id: Int
    let createdBy: String
    let name: String
    let password: String
    let participants: [String: Int]
    let settings: Settings
    let columns: [String: Column]
    let isActive: Bool
}

struct Settings: Decodable {
    let anonymous: Bool
    let timer: Int
}
