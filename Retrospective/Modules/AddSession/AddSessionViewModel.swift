//
//  AddSessionViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI
import Firebase

final class AddSessionViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var pageIndex: AddSessionPages = .name
    @Published var columns: [String: SessionData.Column] = [:]
    @Published var session = SessionData()
    
    let times = [15, 30, 45, 60, 90]
    
    // MARK: - Navigation functions
    
    func navigate(type: NavigateTo) {
        let allPages = AddSessionPages.allCases
        guard let currentIndex = allPages.firstIndex(of: pageIndex) else {
            return
        }
        
        switch pageIndex {
        case .name:
            if type == .next && !checkName() {
                return
            }
        case .options:
            if type == .next && !checkSettings() {
                return
            }
        case .columns:
            if type == .next && !checkColumns() {
                return
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
    
    // MARK: - Validation functions
    
    private func checkName() -> Bool {
        if session.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "İsim alanı boş bırakılamaz"
            showAlert = true
            return false
        }
        return true
    }
    
    private func checkSettings() -> Bool {
        if session.settings.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Şifre alanı boş bırakılamaz"
            showAlert = true
            return false
        }
        return true
    }
    
    private func checkColumns() -> Bool {
        if columns.values.contains(where: { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) || columns.count == 0 {
            alertMessage = "Boş kolon hatası"
            showAlert = true
            return false
        }
        return true
    }
    
    // MARK: - Column management
    
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
    
    // MARK: - Save session
    
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
    
    // MARK: - Deep link and QR code
    
    func createDeepLinkURL(sessionID: String) -> URL? {
        return URL(string: "retrospective://")
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)
            
            let context = CIContext()
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    
    // MARK: - Clear data
    
    func clearData() {
        columns = [:]
        pageIndex = .name
        session = SessionData()
        session.settings.password = ""
        session.settings.time = 15
        session.settings.authorVisibility = false
    }

}
