//
//  DeliveryInfo.swift
//  api-challenge
//
//  Created by Diogo Camargo on 26/08/25.
//

import Foundation

struct DeliveryInfo {
    let month: String  // Ex: "August"
    let day: Int       // Ex: 15

    // Inicializador a partir de Date
    init(from date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM"  // Nome completo do mês
        self.month = formatter.string(from: date)
        
        let calendar = Calendar.current
        self.day = calendar.component(.day, from: date)
    }

    // Computed property para exibição
    var displayText: String {
        "DELIVERY BY \(month), \(String(format: "%02d", day))"
    }
}
