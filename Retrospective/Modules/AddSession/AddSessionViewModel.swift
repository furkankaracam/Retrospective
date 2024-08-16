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
    @Published var alertMessage: String = ""
    @Published var pageIndex: AddSessionPages = .name
    
    @Published var columns: [String: SessionData.Column] = [:]
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
            if !checkSettings() {
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
    
    func checkName() -> Bool {
        if session.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "İsim alanı boş bırakılamaz"
            showAlert = true
            return false
        }
        return true
    }
    
    func checkSettings() -> Bool {
        if session.settings.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Şifre alanı boş bırakılamaz"
            showAlert = true
            return false
        }
        return true
    }
    
    func checkColumns() -> Bool {
        if columns.values.contains(where: { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) || columns.count == 0 {
            alertMessage = "Boş kolon hatası"
            showAlert = true
            return false
        }
        return true
    }
    
    func addColumn() {
        if let lastColumn = columns.values.sorted(by: { $0.order < $1.order }).last, lastColumn.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Son eklenen kolon boş. Yeni bir kolon eklemeden önce doldurmalısınız."
            showAlert = true
            return
        }
        
        let newOrder = (columns.values.map { $0.order }.max() ?? 0) + 1
        let newColumn = SessionData.Column(name: "", order: newOrder)
        columns[newColumn.id] = newColumn
    }
    
    func updateColumnName(for key: String, newName: String) {
        columns[key]?.name = newName
    }
    
    func deleteColumn(at key: String) {
        columns.removeValue(forKey: key)
    }
    
    func save() {
        if checkName() && checkColumns() {
            let ref = Database.database().reference()
            
            session.columns = columns
            
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
