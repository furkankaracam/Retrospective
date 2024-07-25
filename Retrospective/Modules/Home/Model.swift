//
//  Model.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import Foundation

struct Session: Identifiable {
    let id: Int
    let name: String
    let isActive, isEditable, isShowable, isDeletable: Bool
}
