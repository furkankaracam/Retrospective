//
//  AddSessionViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI
import Firebase

final class AddSessionViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = "Hata"
    @Published var pageIndex: AddSessionPages = .name
    
    @Published var columns: [String] = [""]
    
    func navigate(type: NavigateTo) {
        let allPages = AddSessionPages.allCases
        guard let currentIndex = allPages.firstIndex(of: pageIndex) else {
            return
        }
        
        switch type {
        case .previous:
            let previousIndex = max(currentIndex - 1, 0)
            self.pageIndex = allPages[previousIndex]
        case .next:
            let nextIndex = min(currentIndex + 1, allPages.count - 1)
            self.pageIndex = allPages[nextIndex]
        }
    }
    
    func addColumn() {
        if columns.last?.isEmpty == false {
            columns.append("")
        }
    }
    
    func deleteColumn(at index: Int) {
        columns.remove(at: index)
    }
    
    func save(session: SessionData) {
        let ref = Database.database().reference()
        let data = session.toDictionary()
        ref.child("sessions").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Data write failed: \(error.localizedDescription)")
            } else {
                self.pageIndex = .result
            }
        }
    }
}
