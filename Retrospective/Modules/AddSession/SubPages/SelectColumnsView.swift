//
//  SelectColumnsView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectColumnsView: View {
    
    @StateObject var viewModel: AddSessionViewModel
    
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
                        ForEach(Array(viewModel.columns), id: \.value.id) { key, column in
                            HStack {
                                TextField("Kolon metni girin", text: Binding(
                                    get: { column.name },
                                    set: { newName in
                                        viewModel.updateColumnName(for: key, newName: newName)
                                    }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                Button("Sil") {
                                    viewModel.deleteColumn(at: key)
                                }
                                .tint(.red)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                /**.onChange(of: viewModel.columns) { _ in
                 withAnimation {
                 if let lastIndex = viewModel.columns.indices.last {
                 proxy.scrollTo(lastIndex, anchor: .bottom)
                 }
                 }
                 }*/
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
        .onAppear(perform: {
            viewModel.addColumn()
        })
        .padding()
    }
}

#Preview {
    SelectColumnsView(viewModel: AddSessionViewModel())
}
