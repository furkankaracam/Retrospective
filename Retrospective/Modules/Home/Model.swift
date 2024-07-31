//
//  Model.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 26.07.2024.
//

import Foundation

struct SessionResponse: Decodable {
    let sessions: [String: Session]
}

struct Session: Identifiable, Decodable {
    let id: String?
    // let columns: [String: Column]
    let createdBy: String
    let isActive: Bool
    let name: String
    let participants: [String: Int]
    let settings: Settings
}

struct Column: Identifiable, Decodable {
    let id: Int?
    let cards: [String: Card]?
    let name: String
}

struct Card: Identifiable, Decodable {
    let id: Int?
    let createdBy: String
    let text: String
}

struct Settings: Decodable {
    let anonymous, authorVisibility: Bool
    let time: Int
    let password: String
}
