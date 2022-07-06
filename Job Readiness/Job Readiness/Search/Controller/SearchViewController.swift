//
//  ViewController.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 27/06/22.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController {
    private lazy var searchView: SearchView = {
        SearchView(frame: .zero)
    }()

    private var items: [Response] = []
    private let favoriteManager = FavoriteManager()
    private var categoryId = String()
    private var listItemId: [ItemId] = []
    private var network = Network()
    private var itemsPath = String()
    private var didLoad: Bool = true {
        didSet {
            didLoad ? searchView.loading.stopAnimating() : searchView.loading.startAnimating()
        }
    }
    
    private var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        pin(searchView, to: self)
        
        setUpSearchBar()
    }
    
    private func setItems(with itemsPath: String) {
        network.getItems(items: itemsPath) { response in
            self.items = response
            self.didLoad = true
            self.setUpTableView()
            self.searchView.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self

        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
    }
    
    private func searchItems(with categoryId: String) {
        network.getItemsFrom(categoryId) { response in
            guard let response = response
            else {
                self.makeAndPresentAlertError()
                self.didLoad = true
                return
            }

            self.listItemId = response.content.filter({$0.type == "ITEM"})
            var i = 0
            
            for itemId in self.listItemId {
                i += 1
                
                if i == self.listItemId.endIndex {
                    self.itemsPath += itemId.id
                } else {
                    self.itemsPath += itemId.idUrl ?? ""
                }
            }
            
            self.setItems(with: self.itemsPath)
        }
    }
    
    private func makeAndPresentAlertError() {
        let message = "Não foi possível encontrar items!"
        let title = "Items dessa categoria não encontrados!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
    
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.reuseId, for: indexPath) as? SearchTableViewCell
        
        guard let cell = cell,
              !items.isEmpty,
              let thumbnail = items[indexPath.row].item.thumbnail,
              let urlThumbnail = URL(string: thumbnail) else { return UITableViewCell() }
        
        let nameItem = items[indexPath.row].item.title
        let price = items[indexPath.row].item.price ?? 0.0
        
        cell.set(nameItem, price, urlThumbnail)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ItemViewController()
        var item = items[indexPath.row].item
        self.delegate = viewController
        
        searchView.tableView.deselectRow(at: indexPath, animated: true)
        
        item.isFavorited = favoriteManager.consultFavorited(with: item.id)
        
        delegate?.setInformations(with: item)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    private func setUpSearchBar() {
        searchView.searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let categorie = searchView.searchBar.text else {return}
        didLoad = false
        items.removeAll()
        searchView.tableView.reloadData()
        
        itemsPath = String()
        
        network.getCategory(categorieSearch: categorie) { response in
            guard let response = response.first
            else {
                self.makeAndPresentAlertError()
                return
            }

            self.searchItems(with: response.categoryId)
        }
    }
}
