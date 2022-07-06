//
//  FavoriteViewController.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 05/07/22.
//

import UIKit

final class FavoriteViewController: UIViewController {
    private lazy var favoriteView: FavoriteView = {
        FavoriteView(frame: .zero)
    }()
    
    private let network = Network()
    private let favoriteManager = FavoriteManager()
    
    private var favorites: [Items] = []
    
    private var didLoad: Bool = true {
        didSet {
            didLoad ? favoriteView.loadActivityIndicator.stopAnimating() : favoriteView.loadActivityIndicator.startAnimating()
        }
    }
    
    private var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        pin(favoriteView, to: self)
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cleanTableView()
        getItems()
    }
    
    private func cleanTableView() {
        favorites.removeAll()
        favoriteView.tableView.reloadData()
    }
    
    private func getItems() {
        favorites.removeAll()
        favoriteView.tableView.reloadData()
        
        guard favoriteManager.countFavorites() > 0 else {
            favoriteView.noFavoritesLabel.isHidden = false
            reloadInputViews()
            return
        }
        
        favoriteView.noFavoritesLabel.isHidden = true
        
        setDidLoad()
        
        network.getItems(using: favoriteManager.getIdsForPath()) { response in
            self.favorites = response
            self.favorites.sort(by: {$0.item.id > $1.item.id})
            
            self.favoriteView.tableView.reloadData()
            self.setDidLoad()
        }
    }

    private func setUpTableView() {
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self

        favoriteView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    }
    
    private func setDidLoad() {
        didLoad = !didLoad
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as? SearchTableViewCell
        
        guard let cell = cell else { return UITableViewCell() }
        
        let favorite = favorites[indexPath.row].item
        
        cell.set(favorite, isFavorited: self.favoriteManager.consultFavorited(with: favorite.id))
        
        cell.favorite = {
            self.favoriteManager.consultFavorited(with: favorite.id) ? self.favoriteManager.removeFavorited(with: favorite.id) : self.favoriteManager.addFavorited(with: favorite.id)
            
            cell.favoriteButton.isSelected = !cell.favoriteButton.isSelected
            self.getItems()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ItemViewController()
        var item = favorites[indexPath.row].item
        
        delegate = viewController
        item.isFavorited = favoriteManager.consultFavorited(with: item.id)
        
        delegate?.setInformations(with: item)
        favoriteView.tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
