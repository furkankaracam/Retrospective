//
//  SelectTimeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectTimeView: View {
    
    @State private var time: String = ""
    @State private var password: String = ""
    @State private var isHidden: Bool = false
    
    @EnvironmentObject private var newSession: SessionData
    let times = ["5 Min", "10 Min", "15 Min", "30 Min", "1 H", "2 H", "4 H"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Merhaba Furkan")
                .bold()
                .padding(.top)
                .padding(.bottom)
            Text("Oluşturmak istediğin oturumun ayarlarını belirle")
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
            Toggle(isOn: $isHidden) {
                Text("Gizli oturum")
            }
            .toggleStyle(.switch)
            SecureField("Parola (İsteğe Bağlı)", text: $password)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
            
            NavigationButtons(index: 2, checkFunction: .options(duration: time, isHidden: isHidden, password: password))
        }.padding(.horizontal)
            .onAppear {
                if !newSession.time.isEmpty {
                    self.time = newSession.time
                }
                if !newSession.password.isEmpty {
                    self.password = newSession.password
                }
                if !newSession.isHidden {
                    self.isHidden = newSession.isHidden
                }
            }
            .onChange(of: time, {newSession.time = time})
            .onChange(of: password, {newSession.password = password})
            .onChange(of: isHidden, {newSession.isHidden = isHidden})
    }
}

#Preview {
    SelectTimeView().environmentObject(SessionData())
}
