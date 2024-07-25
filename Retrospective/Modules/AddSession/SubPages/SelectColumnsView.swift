//
//  SelectColumnsView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectColumnsView: View {
    @State private var columns: [String] = [""]
    
    var body: some View {
        VStack {
            Text("Merhaba Furkan")
                .bold()
            Text("Oluşturmak istediğin kolonları ekle")
                .padding(.vertical)
            ForEach(columns.indices, id: \.self) { index in
                Text("Kolon \(index + 1)")
                HStack{
                    TextField("Kolon metni girin", text: $columns[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Sil") {
                        deleteColumn(index: index)
                    }.tint(.red)
                }
            }
            
            Button(action: addColumn) {
                Text("Yeni Kolon Ekle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            NavigationButtons(checkFunction: .columns)
        }
        .padding()
    }
    
    private func addColumn() {
        if columns.last != "" {
            columns.append("")
        }
    }
    
    private func deleteColumn(index: Int) {
        columns.remove(at: index)
    }
    
}

#Preview {
    SelectColumnsView()
}
