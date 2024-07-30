//
//  SelectTimeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectTimeView: View {
    
    @State private var time: Int = 0
    @State private var password: String = ""
    @State private var isHidden: Bool = false
    
    @EnvironmentObject private var newSession: SessionData
    let times = [15, 30, 45, 60, 90]
    
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
                        Text("\(time)")
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
            
        }.padding(.horizontal)
            .onAppear {
                if newSession.settings.time == 0 {
                    self.time = newSession.settings.time
                }
                if !newSession.settings.password.isEmpty {
                    self.password = newSession.settings.password
                }
                if !newSession.settings.authorVisibility {
                    self.isHidden = newSession.settings.authorVisibility
                }
            }
            .onChange(of: time, {newSession.settings.time = time})
            .onChange(of: password, {newSession.settings.password = password})
            .onChange(of: isHidden, {newSession.settings.authorVisibility = isHidden})
    }
}

#Preview {
    SelectTimeView().environmentObject(SessionData())
}
