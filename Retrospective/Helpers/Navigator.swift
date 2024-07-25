//
//  Navigator.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

class GlobalNavigator: ObservableObject {
    @Published var destination: AnyView? = nil
}
