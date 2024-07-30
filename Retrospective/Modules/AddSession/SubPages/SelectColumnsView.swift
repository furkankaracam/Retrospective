//
//  SelectColumnsView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectColumnsView: View {
    @State private var columns: [String] = [""]
    @EnvironmentObject private var newSession: SessionData
    
    var body: some View {
        VStack {
            Text("Merhaba Furkan")
                .bold()
            Text("Oluşturmak istediğin kolonları ekle")
                .padding(.vertical)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(columns.indices, id: \.self) { index in
                            HStack {
                                TextField("Kolon metni girin", text: $columns[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                Button("Sil") {
                                    deleteColumn(index: index)
                                }
                                .tint(.red)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .onChange(of: columns) {
                    withAnimation {
                        proxy.scrollTo(columns.indices.last, anchor: .bottom)
                    }
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
            NavigationButtons(checkFunction: .columns(columns: ["selam"]))
        }
        .padding()
        .onAppear {
            if newSession.columns.count > 0 {
                self.columns = newSession.columns
            }
        }
        .onChange(of: columns, {newSession.columns = columns})
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
        .environmentObject(SessionData())
}
