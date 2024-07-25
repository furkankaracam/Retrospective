//
//  NavigationButtons.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

enum CheckFunctions {
    case name(name: String)
    case columns
}

struct NavigationButtons: View {
    @State var index: Int = 1
    var checkFunction: CheckFunctions
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isActive = false
    
    var body: some View {
        
        HStack {
            Group {
                if index > 0 {
                    Button("Vazgeç") {
                    }
                    .tint(.red)
                }
                Button("Devam Et") {
                    switch checkFunction {
                    case .name(let name):
                        checkName(name: name)
                    case .columns:
                        checkOptions(options: "")
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .bold()
            .buttonStyle(.bordered)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Hata"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
    
    private func checkName(name: String) {
        if !name.isEmpty {
            print("İsimden Geçti \(name)")
            isActive = true
        } else {
            alertMessage = "İsim boş olamaz!"
            showAlert = true
        }
    }
    
    private func checkOptions(options: String) {
        if !options.isEmpty {
            print("Ayardan Geçti \(options)")
        }
    }
}

#Preview {
    NavigationButtons(index: 0, checkFunction: .name(name: "Furkan"))
}
