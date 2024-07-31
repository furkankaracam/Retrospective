//
//  SessionDetailViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 31.07.2024.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published var offsets: [Int: CGSize] = [:]
}
