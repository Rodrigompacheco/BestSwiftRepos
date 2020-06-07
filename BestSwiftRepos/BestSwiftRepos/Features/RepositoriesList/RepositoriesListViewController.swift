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
        tableView.register(ActivityIndicatorTableViewCell.self, forCellReuseIdentifier: ActivityIndicatorTableViewCell.identifier)
    }
    
    private func updateUI(dataState: DataState) {
        switch dataState {
        case .initial:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .inserted(let indexPaths):
            DispatchQueue.main.async {
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        case .loading:
            break
        default:
            break
        }
    }
}

extension RepositoriesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.getTotalRepositories()
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell {
                guard let repository = presenter.getRepository(at: indexPath.row) else { return defaultCell }
                
                let repositoryTablePresenter = RepositoryTableItemPresenter(repository: repository)
                cell.attachPresenter(repositoryTablePresenter)
                
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ActivityIndicatorTableViewCell.identifier, for: indexPath) as? ActivityIndicatorTableViewCell {
                cell.attachPresenter(ActivityIndicatorTableItemPresenter())
                
                return cell
            }
        }
        
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return screenBased(regular: 150, reduced: 100, extended: 200)
        } else {
            return 50
        }
    }
}

extension RepositoriesListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.reachedBottom && !presenter.isLoading() && presenter.hasMoreToDownload() else { return }
        
        let indexPath = IndexPath(item: 0, section: 1)
        let footer = tableView.cellForRow(at: indexPath) as? ActivityIndicatorTableViewCell
        footer?.startAnimating()
        
        presenter.fetchData()
    }
}

extension RepositoriesListViewController: RepositoriesView {
    func updateScrollTopBack(_ status: Bool) {
        print(status)
    }
    
    func reloadData(_ state: DataState) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 1)
            let footer = self.tableView.cellForRow(at: indexPath) as? ActivityIndicatorTableViewCell
            footer?.stopAnimating()

            self.updateUI(dataState: state)
        }
    }
    
    func showAlert(_ message: String) {
        print(message)
    }
}
