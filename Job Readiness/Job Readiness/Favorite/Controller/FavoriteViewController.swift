//
//  FavoriteViewController.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 05/07/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var favoriteView: FavoriteView = {
        FavoriteView(frame: .zero)
    }()
    
    private let network = Network()
    private let favoriteManager = FavoriteManager()
    private var favorites: [Response] = []
    
    private var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        pin(favoriteView, to: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cleanTableView()
        getItems()
    }

    private func setUpTableView() {
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self

        favoriteView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    }
    
    private func cleanTableView() {
        favorites.removeAll()
        favoriteView.tableView.reloadData()
    }
    
    private func getItems() {
        guard favoriteManager.countFavorites() > 0 else { return }
        
        favoriteView.loading.startAnimating()
        
        network.getItems(items: favoriteManager.getIdsForPath()) { response in
            self.favorites = response
            self.favorites.sort(by: {$0.item.id > $1.item.id})
            self.setUpTableView()
            self.favoriteView.loading.stopAnimating()
            self.favoriteView.tableView.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as? SearchTableViewCell
        
        guard let cell = cell,
              !favorites.isEmpty,
              let thumbnail = favorites[indexPath.row].item.thumbnail,
              let urlThumbnail = URL(string: thumbnail) else { return UITableViewCell() }
        
        let nameItem = favorites[indexPath.row].item.title
        let price = favorites[indexPath.row].item.price ?? 0.0
        
        cell.set(nameItem, price, urlThumbnail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ItemViewController()
        var item = favorites[indexPath.row].item
        
        favoriteView.tableView.deselectRow(at: indexPath, animated: true)
        
        delegate = viewController
        item.isFavorited = favoriteManager.consultFavorited(with: item.id)
        
        delegate?.setInformations(with: item)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
