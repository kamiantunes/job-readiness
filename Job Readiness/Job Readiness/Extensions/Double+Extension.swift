//
//  Double+Extension.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 06/07/22.
//

import Foundation

extension Double {
    func formatNumberToPrice() -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .decimal

        return "R$ " + (numberFormatter.string(from: NSNumber(value: self)) ?? String())
    }
}
