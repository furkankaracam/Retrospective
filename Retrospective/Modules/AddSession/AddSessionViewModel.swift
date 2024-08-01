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
    
    @Published var name: String = ""
    @Published var time: Int = 0
    @Published var isHidden: Bool = false
    @Published var password: String = ""
    @Published var columns: [String] = [""]
    
    @Published var session = SessionData()
    
    let times = [15, 30, 45, 60, 90]
    
    func navigate(type: NavigateTo) {
        let allPages = AddSessionPages.allCases
        guard let currentIndex = allPages.firstIndex(of: pageIndex) else {
            return
        }
        
        switch pageIndex {
        case .name:
            if !checkName() {
                return
            }
        case .options:
            if !checkName() {
                return
            }
        case .columns:
            switch type {
            case .previous:
                break
            case .next:
                if !checkColumns() {
                    return
                }
            }
        case .result:
            if !checkName() {
                return
            }
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
    
    func checkName() -> Bool {
        if session.name.isEmpty {
            alertMessage = "İsim alanı boş bırakılamaz"
            showAlert = true
            return false
        }
        return true
    }
    
    func checkColumns() -> Bool {
        if columns.isEmpty || (columns.contains("")) {
            print("Buraya girmedi")
            alertMessage = "Boş sütun hatası"
            showAlert = true
            return false
        }
        return true
    }
    
    func addColumn() {
        if columns.isEmpty || columns.last != "" {
            columns.append("")
        } else {
            alertMessage = "Boş sütun mevcut!"
            showAlert = true
        }
    }
    
    func deleteColumn(at index: Int) {
        columns.remove(at: index)
    }
    
    func save() {
        if checkColumns() {
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
}
