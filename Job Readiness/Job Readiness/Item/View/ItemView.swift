//
//  ItemView.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/06/22.
//

import UIKit

class ItemView: UIView {
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
    
    private lazy var stackTopView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.backgroundColor = .yellow
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    lazy var titleItemLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Volkswagen Fox 1.6 Connect"
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
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 24
        
        return stack
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
    
    lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        loading.hidesWhenStopped = true
        loading.style = .large
        
        return loading
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
        addSubview(loading)
        setUpConstraintLoading()
        
        addSubview(headerView)
        setUpConstraintHeaderView()
        
        headerView.addSubview(stackTopView)
        setUpConstraintStackTopView()
        
        stackTopView.addArrangedSubview(backButton)
        stackTopView.addArrangedSubview(favoriteButton)
        
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
    }
    
    private func setUpConstraintHeaderView() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
    
    private func setUpConstraintStackTopView() {
        NSLayoutConstraint.activate([
            stackTopView.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 11),
            stackTopView.leadingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackTopView.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackTopView.bottomAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.bottomAnchor, constant: -11)
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
    
    private func setUpConstraintLoading() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
