//
//  NavigationButtons.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

enum CheckFunctions {
    case name(name: String)
    case options(duration: String, isHidden: Bool, password: String)
    case columns(columns: [String])
    case result
}

struct NavigationButtons: View {
    @State var index: Int = 1
    var checkFunction: CheckFunctions
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isActive = false
    @State private var destinationView: AnyView?
    
    @EnvironmentObject var vm: AddSessionViewModel
    @StateObject var viewModel = AddSessionViewModel()
    
    var body: some View {
        VStack {
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
                        case .options(let duration, let isHidden, let password):
                            checkOptions(duration: duration, isHidden: isHidden, password: password)
                        case .columns(columns: _):
                            checkColumns(options: "")
                        case .result:
                            checkResult(options: "")
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
            
            NavigationLink(destination: destinationView, isActive: $isActive) {
            }
        }
    }
    
    private func checkName(name: String) {
        if !name.isEmpty {
            destinationView = AnyView(AddSessionView(pageIndex: .constant(.options)))
            isActive = true
        } else {
            alertMessage = "İsim boş olamaz!"
            showAlert = true
        }
    }
    
    private func checkOptions(duration: String, isHidden: Bool, password: String) {
        destinationView = AnyView(AddSessionView(pageIndex: .constant(.columns)))
        isActive = true
    }
    
    private func checkColumns(options: String) {
        destinationView = AnyView(AddSessionView(pageIndex: .constant(.result)))
        isActive = true
    }
    
    private func checkResult(options: String) {
        if !options.isEmpty {
            print("Ayardan Geçti \(options)")
        }
    }
}

#Preview {
    NavigationButtons(index: 0, checkFunction: .name(name: "Furkan"))
}
