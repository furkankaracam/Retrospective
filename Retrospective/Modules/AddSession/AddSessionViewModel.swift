//
//  AddSessionViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import Foundation
import Firebase

final class AddSessionViewModel: ObservableObject {
    @Published var sessionData = SessionData()
}
