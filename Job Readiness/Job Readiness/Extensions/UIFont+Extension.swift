import UIKit

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
