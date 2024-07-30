//
//  SelectColumnsView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectColumnsView: View {
    
    @EnvironmentObject private var newSession: SessionData
    @StateObject private var viewModel = AddSessionViewModel()
    
    var body: some View {
        VStack {
            Text("Merhaba Furkan")
                .bold()
            Text("Oluşturmak istediğin kolonları ekle")
                .padding(.vertical)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.columns.indices, id: \.self) { index in
                            HStack {
                                TextField("Kolon metni girin", text: $viewModel.columns[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                Button("Sil") {
                                    viewModel.deleteColumn(at: index)
                                }
                                .tint(.red)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .onChange(of: viewModel.columns) {
                    withAnimation {
                        proxy.scrollTo(viewModel.columns.indices.last, anchor: .bottom)
                    }
                }
            }
            Button(action: viewModel.addColumn) {
                Text("Yeni Kolon Ekle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .onAppear {
            if newSession.columns.count > 0 {
                viewModel.columns = newSession.columns
            }
        }
        .onChange(of: viewModel.columns) {
            newSession.columns = viewModel.columns
        }
    }
}

#Preview {
    SelectColumnsView()
        .environmentObject(SessionData())
}
