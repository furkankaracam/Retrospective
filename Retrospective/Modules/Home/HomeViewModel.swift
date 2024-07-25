//
//  HomeViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var sessions: [Session] = [
        Session(id: 1, name: "Oturum 1", isActive: true, isEditable: true, isShowable: true, isDeletable: false),
        Session(id: 2, name: "Oturum 2", isActive: false, isEditable: true, isShowable: true, isDeletable: false),
        Session(id: 3, name: "Oturum 3", isActive: true, isEditable: true, isShowable: true, isDeletable: false),
        Session(id: 4, name: "Oturum 4", isActive: false, isEditable: true, isShowable: true, isDeletable: false)
    ]
    
    @Published var oldSessions: [Session] = [
        Session(id: 5, name: "Oturum 1", isActive: false, isEditable: false, isShowable: true, isDeletable: true),
        Session(id: 6, name: "Oturum 2", isActive: false, isEditable: false, isShowable: true, isDeletable: true)
    ]
    
}
