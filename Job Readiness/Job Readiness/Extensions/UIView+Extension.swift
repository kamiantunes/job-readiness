import UIKit

extension UIView {
    func pin(to navigation: UIViewController) {
        translatesAutoresizingMaskIntoConstraints = false

        navigation.view.addSubview(self)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: navigation.view.topAnchor),
            leadingAnchor.constraint(equalTo: navigation.view.leadingAnchor),
            centerYAnchor.constraint(equalTo: navigation.view.centerYAnchor),
            trailingAnchor.constraint(equalTo: navigation.view.trailingAnchor)
        ])
    }
    
    func pinNavBar(using navBar: UINavigationBar) {
        addSubview(navBar)

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
