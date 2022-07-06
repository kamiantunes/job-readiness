//
//  Extension.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 28/06/22.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

    static let backgroundHome = UIColor.init(hex: 0xD4F4FF)
}

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

func formatNumberToDecimal(value:Double) -> String {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.locale = Locale(identifier: "pt_BR")
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.numberStyle = .decimal

    return "R$ " + (numberFormatter.string(from: NSNumber(value:value)) ?? String())
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
        guard let font = UIFont(name: type.getFontName(), size: size) else {return UIFont.systemFont(ofSize: size, weight: type.getWeight())}
        
        return font
    }
}
