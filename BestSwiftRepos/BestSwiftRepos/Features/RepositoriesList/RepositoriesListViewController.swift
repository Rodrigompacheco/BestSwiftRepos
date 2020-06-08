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
    private let scrollBackButton = UIButton()
    
    init(presenter: RepositoriesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        setupScrollBackButton()
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
    
    private func setupScrollBackButton() {
        self.view.addSubview(scrollBackButton)
        
        scrollBackButton.snp.makeConstraints {
            $0.trailing.equalTo(self.view).offset(-20)
            $0.bottom.equalTo(self.view).offset(-20)
            $0.height.width.equalTo(screenBased(regular: 20, reduced: 16, extended: 60))
        }
        
        scrollBackButton.addTarget(self, action: #selector(scrollBackButtonPressed), for: .touchUpInside)
        scrollBackButton.setImage(UIImage(named: "arrow_up"), for: .normal)
        changeScrollBackBtnState(to: true)
    }
    
    @objc func scrollBackButtonPressed() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    private func changeScrollBackBtnState(to isHidden: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollBackButton.alpha = isHidden ? 0 : 1
        })
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
        changeScrollBackBtnState(to: !(scrollView.contentOffset.y > 0))
        
        guard scrollView.reachedBottom && !presenter.isLoading() && presenter.hasMoreToDownload() else { return }
        
        let footer = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? ActivityIndicatorTableViewCell
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
            let footer = self.tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? ActivityIndicatorTableViewCell
            footer?.stopAnimating()

            self.updateUI(dataState: state)
        }
    }
    
    func showAlert(_ message: String) {
        let footer = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? ActivityIndicatorTableViewCell
        footer?.stopAnimating()
            
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
