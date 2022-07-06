//
//  Extension.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 28/06/22.
//

import UIKit

func pin(_ view: UIView, to navigation: UIViewController) {
    view.translatesAutoresizingMaskIntoConstraints = false

    navigation.view.addSubview(view)

    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: navigation.view.topAnchor),
        view.leadingAnchor.constraint(equalTo: navigation.view.leadingAnchor),
        view.centerYAnchor.constraint(equalTo: navigation.view.centerYAnchor),
        view.trailingAnchor.constraint(equalTo: navigation.view.trailingAnchor)
    ])
}

func formatNumberToDecimal(value:Double) -> String {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.locale = Locale(identifier: "pt_BR")
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.numberStyle = .decimal

    return "R$ " + (numberFormatter.string(from: NSNumber(value:value)) ?? String())
}

extension UISearchBar {
    func clearBackgroundColor() {
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }

        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                subview.alpha = 0
            }
        }
    }
}

extension UIFont {
    enum FontType {
        case thin
        case regular
        
        func getFontName () -> String {
            switch self {
            case .thin:
                return "ProximaNovaT-Thin"
            case .regular:
                return "ProximaNova-Regular"
            }
        }
        
        func getWeight() -> UIFont.Weight {
            switch self {
            case .thin:
                return .thin
            case .regular:
                return .regular
            }
        }
    }
    
    static func customFont(type: FontType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.getFontName(), size: size) else {
            return UIFont.systemFont(ofSize: size, weight: type.getWeight())
        }
        
        return font
    }
}
