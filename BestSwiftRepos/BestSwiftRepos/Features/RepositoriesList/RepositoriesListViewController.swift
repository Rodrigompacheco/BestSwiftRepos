//
//  MainViewController.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit
import SnapKit

class RepositoriesListViewController: UIViewController {

    private let presenter: RepositoriesListPresenter
    private let tableView = UITableView()
    
    init(presenter: RepositoriesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        presenter.attachView(view: self)
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = AppColorPalette.mainBackground
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
    }
}

extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTotalRepositories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.className, for: indexPath) as? RepositoryTableViewCell {
            guard let repository = presenter.getRepository(at: indexPath.row) else { return defaultCell }
            
            let repositoryTablePresenter = RepositoryTableItemPresenter(repository: repository)
            cell.attachPresenter(repositoryTablePresenter)
            
            return cell
        }
        
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenBased(regular: 150, reduced: 100, extended: 200)
    }
}

extension RepositoriesListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("SCROLLOOOO")
    }
}

extension RepositoriesListViewController: RepositoriesView {
    func updateScrollTopBack(_ status: Bool) {
        print(status)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(_ message: String) {
        print(message)
    }
}
