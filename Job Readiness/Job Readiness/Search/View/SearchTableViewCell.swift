//
//  SearchTableViewCell.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/06/22.
//

import UIKit
import AlamofireImage

final class SearchTableViewCell: UITableViewCell {
    static let reuseId = "SearchTableViewCell"
    
    var favorite: (() -> Void)?
    var isFavorited: Bool = false
    let availableQuantityText = "Quantidade Disponível: "
    let soldQuantityText = "Vendidos: "
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameItemLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 20)
        
        return label
    }()
    
    private lazy var availableQuantityLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textColor = .gray
        label.text = availableQuantityText
        
        return label
    }()
    
    private lazy var soldQuantityLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = soldQuantityText
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var itemStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.isUserInteractionEnabled = true
        setUpViews()
    }
    
    func set(_ item: Item, isFavorited: Bool) {
        favoriteButton.isSelected = isFavorited
        
        nameItemLabel.text = item.title
        priceLabel.text = item.price.formatNumberToPrice()
        availableQuantityLabel.text = availableQuantityText + String(item.availableQuantity)
        soldQuantityLabel.text = soldQuantityText + String(item.soldQuantity)
        
        if let thumbnail = item.thumbnail, let thumbnailUrl = URL(string: thumbnail){
            itemImageView.af.setImage(withURL: thumbnailUrl)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(itemStackView)
        setUpConstraintsItemStackView()
        
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(labelsStackView)
        
        setUpConstraintsItemImageView()
        
        labelsStackView.addArrangedSubview(nameItemLabel)
        labelsStackView.addArrangedSubview(priceLabel)
        labelsStackView.addArrangedSubview(availableQuantityLabel)
        labelsStackView.addArrangedSubview(soldQuantityLabel)
        
        addSubview(favoriteButton)
        setUpConstraintsFavoriteButton()
    }
    
    private func setUpConstraintsItemStackView() {
        NSLayoutConstraint.activate([
            itemStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            itemStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            itemStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            itemStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpConstraintsItemImageView() {
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 131),
            itemImageView.widthAnchor.constraint(equalToConstant: 131)
        ])
    }
    
    private func setUpConstraintsFavoriteButton() {
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: itemImageView.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor)
        ])
    }
    
    @objc private func didTapFavorite() {
        favorite?()
    }
}
