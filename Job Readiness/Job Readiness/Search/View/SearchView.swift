//
//  SearchView.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 28/06/22.
//

import UIKit

final class SearchView: UIView {
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        
        view.setUpView()
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.clearBackgroundColor()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.layer.masksToBounds = true

        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    lazy var loadActivityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        
        return activityIndicatorView
    }()
    
    lazy var noCategoryLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Insira uma categoria 🔍"
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
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

        headerView.addSubview(searchBar)
        setUpConstraintSearchBar()

        addSubview(tableView)
        setUpConstraintsTableView()
        
        addSubview(loadActivityIndicator)
        setUpConstraintLoadActivityIndicatorView()
        
        addSubview(noCategoryLabel)
        setUpConstraintNoCategoryLabel()
    }
    
    private func setUpConstraintHeaderView() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
    
    private func setUpConstraintSearchBar() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 7),
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -7)
        ])
    }
    
    private func setUpConstraintsTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpConstraintLoadActivityIndicatorView() {
        NSLayoutConstraint.activate([
            loadActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setUpConstraintNoCategoryLabel() {
        NSLayoutConstraint.activate([
            noCategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            noCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            noCategoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
