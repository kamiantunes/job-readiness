//
//  ViewControllerTest.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 27/06/22.
//

import UIKit

class ItemViewController: UIViewController {

    private lazy var itemView: ItemView = {
        ItemView(frame: .zero)
    }()
    
    private var item: Item?
    private let network = Network()
    private let favorites = FavoriteManager()
    
    private var willLoad: Bool = false {
        didSet {
            willLoad ? itemView.loading.startAnimating() : itemView.loading.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        willLoad = true
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        addActions()
        addInformation()
        getDescription()
        willLoad = false
        
        pin(itemView, to: self)
    }
    
    private func addActions() {
        itemView.backButton.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
        itemView.favoriteButton.addTarget(self, action: #selector(didFavoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func didBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didFavoriteButtonTapped() {
        guard let item = item else { return }
        
        itemView.favoriteButton.isSelected ?
            favorites.removeFavorited(with: item.id) : favorites.addFavorited(with: item.id)
        
        itemView.favoriteButton.isSelected = !itemView.favoriteButton.isSelected
        itemView.reloadInputViews()
    }
    
    private func addInformation() {
        guard let item = item else { return }

        itemView.titleItemLabel.text = item.title
        itemView.priceLabel.text = formatNumberToDecimal(value: item.price ?? 0.0)
        
        if let thumbnail = item.pictures[0].url, let urlThumbnail = URL(string: thumbnail){
            itemView.itemImageView.af.setImage(withURL: urlThumbnail)
        }
        
    }
    
    private func getDescription() {
        guard let item = item else { return }
        
        network.getDescription(item.id) { response in
            guard let response = response else { return }

            self.itemView.descriptionItemLabel.text = response.descriptionText
        }
    }
}

protocol ItemViewControllerDelegate: AnyObject {
    func setInformations(with item: Item)
}

extension ItemViewController: ItemViewControllerDelegate {
    func setInformations(with item: Item) {
        self.item = item
        itemView.favoriteButton.isSelected = item.isFavorited
    }
}
