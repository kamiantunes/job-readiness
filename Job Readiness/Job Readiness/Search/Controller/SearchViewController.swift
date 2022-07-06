//
//  ViewController.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 27/06/22.
//

import UIKit

final class SearchViewController: UIViewController {
    private lazy var searchView: SearchView = {
        SearchView(frame: .zero)
    }()

    private let favoriteManager = FavoriteManager()
    private var network = Network()
    
    private var listItems: [Items] = []
    
    private var didLoad: Bool = true {
        didSet {
            didLoad ? searchView.activityIndicator.stopAnimating() : searchView.activityIndicator.startAnimating()
        }
    }
    
    private var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        pin(searchView, to: self)
        
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchView.searchBar.delegate = self
    }
    
    private func searchItems(with categoryId: String) {
        network.getItemsFrom(categoryId) { response in
            guard let response = response else {
                self.makeAndPresentAlertError()
                self.setDidLoad()
                return
            }
            
            let listId = response.content.filter({$0.type == "ITEM"})
            self.setItems(with: self.makeUrlPath(using: listId))
        }
    }
    
    private func makeUrlPath(using listId: [IdItem]) -> String {
        var itemsPath = String()
        
        for itemId in listId {
            let idPath = itemId.id == listId.last?.id ? itemId.id : itemId.id + ","
            
            itemsPath += idPath
        }
        
        return itemsPath
    }
    
    private func setItems(with itemsPath: String) {
        network.getItems(using: itemsPath) { response in
            self.listItems = response
            self.setDidLoad()
            self.setUpTableView()
            self.searchView.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self

        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    }
    
    private func makeAndPresentAlertError() {
        let message = "Não foi possível encontrar items!"
        let title = "Items desta categoria não foram encontrados!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setDidLoad() {
        didLoad = !didLoad
    }
    
    private func cleanTableView() {
        listItems.removeAll()
        searchView.tableView.reloadData()
    }
}
    
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as? SearchTableViewCell
        let item = listItems[indexPath.row].item
        
        guard let cell = cell, let thumbnail = item.thumbnail, let urlThumbnail = URL(string: thumbnail) else { return UITableViewCell() }
        
        let nameItem = item.title
        let price = item.price ?? -1
        
        cell.set(nameItem, price, urlThumbnail)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ItemViewController()
        var item = listItems[indexPath.row].item
        
        self.delegate = viewController
        item.isFavorited = favoriteManager.consultFavorited(with: item.id)
        
        delegate?.setInformations(with: item)
        searchView.tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let categorie = searchView.searchBar.text else { return }
        
        setDidLoad()
        cleanTableView()
        
        network.getCategory(using: categorie) { response in
            guard let response = response.first else {
                self.makeAndPresentAlertError()
                return
            }

            self.searchItems(with: response.categoryId)
        }
    }
}
