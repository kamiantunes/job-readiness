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
            didLoad ? searchView.loadActivityIndicator.stopAnimating() : searchView.loadActivityIndicator.startAnimating()
        }
    }
    
    private var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.pin(to: self)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchView.tableView.reloadData()
    }
    
    private func setUpView() {
        searchView.searchBar.delegate = self
        searchView.noCategoryLabel.isHidden = false
        
        setUpTableView()
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
            self.listItems.sort(by: {$0.item.id > $1.item.id})
            self.setDidLoad()
            self.searchView.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self

        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    }
    
    private func makeAndPresentAlertError() {
        let message = "Verifique se a palavra está escrita corretamente."
        let title = "Não encontramos itens!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true){
            self.setHidden()
        }
    }
    
    private func setDidLoad() {
        didLoad = !didLoad
    }
    
    private func cleanTableView() {
        listItems.removeAll()
        searchView.tableView.reloadData()
    }
    
    private func setHidden() {
        self.searchView.noCategoryLabel.isHidden = false
    }
}
    
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as? SearchTableViewCell
        
        guard let cell = cell else { return UITableViewCell() }
        
        let item = listItems[indexPath.row].item
        
        cell.set(item, isFavorited: favoriteManager.consultFavorited(with: item.id))
        
        cell.favorite = {
            self.favoriteManager.consultFavorited(with: item.id) ? self.favoriteManager.removeFavorited(with: item.id) : self.favoriteManager.addFavorited(with: item.id)
            
            cell.favoriteButton.isSelected = !cell.favoriteButton.isSelected
        }
        
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
        
        searchView.noCategoryLabel.isHidden = true
        setDidLoad()
        cleanTableView()
        
        network.getCategory(using: categorie) { response in
            guard let response = response.first else {
                self.makeAndPresentAlertError()
                self.setDidLoad()
                return
            }

            self.searchItems(with: response.categoryId)
        }
    }
}
