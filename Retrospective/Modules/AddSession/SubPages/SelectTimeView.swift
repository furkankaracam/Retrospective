//
//  SelectTimeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectTimeView: View {
    
    @State var time: String = ""
    let times = ["5 Min", "10 Min", "15 Min", "30 Min", "1 H", "2 H", "4 H"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Merhaba Furkan")
                .bold()
                .padding(.top)
                .padding(.bottom)
            Text("Oluşturmak istediğin oturumun süresini belirle")
            HStack {
                Text("Süre")
                Spacer()
                Picker("Süre Seçimi", selection: $time) {
                    ForEach(times, id: \.self) { time in
                        Text(time)
                    }
                }
                .pickerStyle(.inline)
            }
            NavigationButtons(index: 2, checkFunction: .time)
        }.padding(.horizontal)
    }
}

#Preview {
    SelectTimeView()
}
