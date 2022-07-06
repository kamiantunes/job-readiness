//
//  SearchView.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 28/06/22.
//

import UIKit

class SearchView: UIView {
    private lazy var headerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.clearBackgroundColor()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.masksToBounds = true

        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .white
        
        return tableView
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
        addSubview(headerView)
        setUpConstraintHeaderView()

        headerView.addSubview(searchBar)
        setUpConstraintSearchTextField()

        addSubview(tableView)
        setUpConstraintsTableView()
        
        addSubview(loading)
        setUpConstraintLoading()
    }
    
    private func setUpConstraintHeaderView() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
    
    private func setUpConstraintSearchTextField() {
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
    
    private func setUpConstraintLoading() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
