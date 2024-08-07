//
//  Enums.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 30.07.2024.
//

enum AddSessionPages: CaseIterable {
    case name
    case options
    case columns
    case result
}

enum NavigateTo {
    case previous
    case next
}

enum Tabs {
    case sessions
    case oldSessions
    case addSession
    case profile
}

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}
