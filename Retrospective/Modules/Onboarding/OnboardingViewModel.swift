//
//  OnboardingViewModel.swift
//  Retrospective
//
//  Created by Furkan Karaçam on 14.08.2024.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    let onboardingItems = [
        OnboardingItem(title: "Hoşgeldiniz", description: "Retrospektif toplantılarınızı oluşturun ve ekibinizin ilerlemesini değerlendirin. İhtiyacınıza göre oturumlar ekleyin ve yönetin.", lottieName: "lottie1"),
        OnboardingItem(title: "Retrospektif Toplantılarınızı Başlatın", description: "Retrospektif toplantılarınızı oluşturun ve ekibinizin ilerlemesini değerlendirin. İhtiyacınıza göre oturumlar ekleyin ve yönetin.", lottieName: "lottie2"),
        OnboardingItem(title: "Kolayca Zamanlayın", description: "Toplantılarınızı kolayca planlayın. Tarih ve saat belirleyerek, zaman yönetiminizi optimize edin ve ekibinizin uygunluk durumunu kontrol edin.", lottieName: "lottie3"),
        OnboardingItem(title: "Katılımcılar ve Geri Bildirimler", description: "Katılımcıları ekleyin ve toplantı sonrası geri bildirimleri toplayın. Ekip üyelerinin yorumlarını ve önerilerini hızlıca değerlendirin.", lottieName: "lottie4"),
    ]
}
