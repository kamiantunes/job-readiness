//
//  ViewControllerTest.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 27/06/22.
//

import UIKit

final class ItemViewController: UIViewController {
    private lazy var itemView: ItemView = {
        ItemView(frame: .zero)
    }()
    
    private var item: Item?
    private let network = Network()
    private let favoriteManager = FavoriteManager()
    
    private var didLoad: Bool = true {
        didSet {
            didLoad ? itemView.loadActivityIndicator.stopAnimating() : itemView.loadActivityIndicator.startAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        itemView.pin(to: self)
        
        setUpDetails()
    }
    
    private func setUpDetails() {
        setDidLoad()
        addActions()
        addInformation()
        getDescription()
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
        
        itemView.favoriteButton.isSelected ? favoriteManager.removeFavorited(with: item.id) : favoriteManager.addFavorited(with: item.id)
        
        itemView.favoriteButton.isSelected = !itemView.favoriteButton.isSelected
        itemView.reloadInputViews()
    }
    
    private func addInformation() {
        guard let item = item else { return }

        itemView.titleItemLabel.text = item.title
        itemView.priceLabel.text = item.price.formatNumberToPrice()
        
        if let thumbnail = item.pictures.first?.url, let urlThumbnail = URL(string: thumbnail) {
            itemView.itemImageView.af.setImage(withURL: urlThumbnail)
        }
    }
    
    private func getDescription() {
        guard let item = item else { return }
        
        network.getDescription(using: item.id) { response in
            guard let response = response else { return }

            self.setDidLoad()
            self.itemView.descriptionItemLabel.text = response.descriptionText
        }
    }
    
    private func setDidLoad() {
        didLoad = !didLoad
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
