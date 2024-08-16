//
//  SelectColumnsView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectColumnsView: View {
    
    @StateObject var viewModel: AddSessionViewModel
    @State private var lastColumnKey: String?
    
    var body: some View {
        VStack {
            Text("Merhaba Furkan")
                .bold()
                .font(.title)
            Text("Oluşturmak istediğin kolonları ekle")
                .padding(.vertical)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.columns.sorted(by: { $0.value.order < $1.value.order }), id: \.key) { key, column in
                            HStack {
                                TextField("Kolon metni girin", text: Binding(
                                    get: { column.name },
                                    set: { newName in
                                        viewModel.updateColumnName(for: key, newName: newName)
                                    }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .padding()
                                Button("Sil") {
                                    viewModel.deleteColumn(at: key)
                                }
                                .tint(.red)
                            }
                            .padding(.horizontal)
                            .id(key)
                        }
                    }
                }
                .onChange(of: viewModel.columns.count) { _ in
                    if let lastColumnKey = lastColumnKey {
                        withAnimation {
                            proxy.scrollTo(lastColumnKey, anchor: .bottom)
                        }
                    }
                }
            }
            
            Button(action: {
                viewModel.addColumn()
                if let lastColumnKey = viewModel.columns.keys.sorted(by: { viewModel.columns[$0]?.order ?? 0 < viewModel.columns[$1]?.order ?? 0 }).last {
                    self.lastColumnKey = lastColumnKey
                    withAnimation {
                        ScrollViewReader { proxy in
                            // proxy.scrollTo(lastColumnKey, anchor: .bottom)
                        }
                    }
                }
            }) {
                Text("Yeni Kolon Ekle")
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .bold()
            }
            .padding()
            Spacer()
        }
        .onAppear(perform: {
            viewModel.addColumn()
        })
        .padding()
    }
}

#Preview {
    SelectColumnsView(viewModel: AddSessionViewModel())
}
