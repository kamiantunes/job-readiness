//
//  SearchTableViewCell.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/06/22.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static let reuseId = "SearchTableViewCell"
    
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
    
    private lazy var firstInformationLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "2019 - 37.000 Km"
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var secondInformationLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Bs.As. G.B.A. Norte"
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 4
        
        return stack
    }()
    
    private lazy var itemStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .equalSpacing
        stack.spacing = 10
        
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        setUpViews()
    }
    
    func set(_ nameItem: String, _ price: Double, _ thumbnail: URL) {
        nameItemLabel.text = nameItem
        priceLabel.text = formatNumberToDecimal(value: price)
        itemImageView.af.setImage(withURL: thumbnail)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(itemStackView)
        setUpConstraintsItemStackView()
        
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(labelsStackView)
        
        setUpConstraintsItemImageView()
        
        labelsStackView.addArrangedSubview(nameItemLabel)
        labelsStackView.addArrangedSubview(priceLabel)
        labelsStackView.addArrangedSubview(firstInformationLabel)
        labelsStackView.addArrangedSubview(secondInformationLabel)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}