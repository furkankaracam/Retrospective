//
//  CustomCell.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 24.07.2024.
//

import SwiftUI

struct CustomCell: View {
    
    let session: Session
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Text(session.name)
                Spacer()
                Text(session.isActive ? "Aktif" : "Pasif")
                    .foregroundColor(session.isActive ? .green : .red)
                Spacer()
                if session.isShowable {
                    Button(action: {
                    }, label: {
                        Image(systemName: "eye")
                    })
                }
                if session.isEditable {
                    Button(action: {
                    }, label: {
                        Image(systemName: "pencil")
                    })
                }
                if session.isDeletable {
                    Button(action: {
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    CustomCell(session: Session(id: 1, name: "Deneme", isActive: true, isEditable: false, isShowable: true, isDeletable: true))
}
