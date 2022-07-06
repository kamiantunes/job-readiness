//
//  FavoriteView.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 05/07/22.
//

import UIKit

final class FavoriteView: UIView {

    private lazy var headerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    private lazy var favoriteLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Favoritos"
        label.font = UIFont.customFont(type: .regular, size: 20)
        
        return label
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
        
        headerView.addSubview(favoriteLabel)
        setUpConstraintFavoriteLabel()
        
        addSubview(tableView)
        setUpConstraintTableView()
        
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
    
    private func setUpConstraintFavoriteLabel() {
        NSLayoutConstraint.activate([
            favoriteLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            favoriteLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setUpConstraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpConstraintLoadActivityIndicator() {
        NSLayoutConstraint.activate([
            loadActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
