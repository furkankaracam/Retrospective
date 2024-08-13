//
//  Extensions.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 13.08.2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Notification.Name {
    static let sessionDetailDidDisappear = Notification.Name("sessionDetailDidDisappear")
}
