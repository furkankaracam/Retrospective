//
//  NavigationButtons.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct NavigationButtons: View {
    
    @ObservedObject var viewModel: AddSessionViewModel
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    if viewModel.pageIndex != .name {
                        Button("Geri Dön") {
                            viewModel.navigate(type: .previous)
                        }
                        .tint(.red)
                    }
                    if viewModel.pageIndex != .columns {
                        Button("Devam Et") {
                            viewModel.navigate(type: .next)
                        }
                    } else {
                        Button("Kaydet") {
                            viewModel.save()
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .bold()
                .buttonStyle(.bordered)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Hata"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Tamam")))
            }
        }
    }
}

#Preview {
    NavigationButtons(viewModel: AddSessionViewModel())
}
