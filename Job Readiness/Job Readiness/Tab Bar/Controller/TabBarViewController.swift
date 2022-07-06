//
//  TabBarViewController.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 27/06/22.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
        setupVCs()
    }
    
    private func setUpTabBar() {
        UITabBar.appearance().barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: SearchViewController(), title: NSLocalizedString("Busca", comment: String()), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: FavoriteViewController(), title: NSLocalizedString("Favoritos", comment: String()), image: UIImage(systemName: "heart.fill")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let view = UIImageView()
        
        view.backgroundColor = .systemYellow
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
    
        return navController
    }
}
