//
//  TimeFormatter.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 7.08.2024.
//

import Foundation

class TimeFormatterUtility {    
    static func formatTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: TimeInterval(seconds)) ?? "00:00"
    }
}
