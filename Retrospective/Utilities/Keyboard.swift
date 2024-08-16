//
//  Keyboard.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 16.08.2024.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
