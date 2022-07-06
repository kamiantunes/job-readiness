//
//  ItemView.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/06/22.
//

import UIKit

final class ItemView: UIView {
    private lazy var headerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setBackgroundImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .black
        
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.backgroundColor = .yellow
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    lazy var titleItemLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 24)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 275).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 36)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var itemStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Descrição"
        label.font = UIFont.customFont(type: .regular, size: 24)
        
        return label
    }()
    
    lazy var descriptionItemLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var loadActivityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        
        return activityIndicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(headerView)
        setUpConstraintHeaderView()
        
        headerView.addSubview(topStackView)
        setUpConstraintTopStackView()
        
        topStackView.addArrangedSubview(backButton)
        topStackView.addArrangedSubview(favoriteButton)
        
        addSubview(scrollView)
        setUpConstraintScrollView()
        
        scrollView.addSubview(contentView)
        setUpConstraintContentView()
        
        contentView.addSubview(itemStackView)
        setUpConstraintItemStackView()
        
        itemStackView.addArrangedSubview(titleItemLabel)
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(priceLabel)
        itemStackView.addArrangedSubview(descriptionLabel)
        itemStackView.addArrangedSubview(descriptionItemLabel)
        
        addSubview(loadActivityIndicator)
        setUpConstraintLoadActivityIndicator()
    }
    
    private func setUpConstraintHeaderView() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
    
    private func setUpConstraintTopStackView() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 11),
            topStackView.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            topStackView.bottomAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.bottomAnchor, constant: -11)
        ])
    }
    
    private func setUpConstraintScrollView() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpConstraintContentView() {
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setUpConstraintItemStackView() {
        NSLayoutConstraint.activate([
            itemStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            itemStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setUpConstraintLoadActivityIndicator() {
        NSLayoutConstraint.activate([
            loadActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
