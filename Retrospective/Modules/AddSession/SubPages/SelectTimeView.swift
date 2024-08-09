//
//  SelectTimeView.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 25.07.2024.
//

import SwiftUI

struct SelectTimeView: View {
    
    @State private var time: Int = 15
    @State private var password: String = ""
    @State private var isHidden: Bool = false
    
    @StateObject var viewModel: AddSessionViewModel
    
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
                    ForEach(viewModel.times, id: \.self) { time in
                        Text("\(time)")
                    }
                }
                .pickerStyle(.inline)
            }
            Toggle(isOn: $isHidden) {
                Text("Gizli oturum")
            }
            .toggleStyle(.switch)
            SecureField("Parola (Zorunlu)", text: $password)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding()
            
        }.padding(.horizontal)
            .onAppear {
                if viewModel.time == 0 {
                    self.time = viewModel.session.settings.time
                }
                if !viewModel.password.isEmpty {
                    self.password = viewModel.session.settings.password
                }
                if !viewModel.session.settings.authorVisibility {
                    self.isHidden = viewModel.session.settings.authorVisibility
                }
            }
            .onChange(of: time, {viewModel.session.settings.time = time})
            .onChange(of: password, {viewModel.session.settings.password = password})
            .onChange(of: isHidden, {viewModel.session.settings.authorVisibility = isHidden})
    }
}

#Preview {
    SelectTimeView(viewModel: AddSessionViewModel())
}
