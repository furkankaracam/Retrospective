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
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    if viewModel.pageIndex != .columns {
                        Button("Devam Et") {
                            viewModel.navigate(type: .next)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    } else {
                        Button("Kaydet") {
                            viewModel.save()
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .bold()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Hata"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Tamam")))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationButtons(viewModel: AddSessionViewModel())
}
