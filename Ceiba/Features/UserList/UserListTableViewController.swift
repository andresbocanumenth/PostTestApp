//
//  UserListTableViewController.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/1/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    fileprivate let cellIdentifier = "userCell"
    fileprivate let userListViewModel = UserListViewModel()
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .lightGray
        configureBindings()
        configureSearchController()
        Current.syncService.firstLoad()
    }
    
    func configureSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    func configureBindings() {
        userListViewModel.refreshData = {
            self.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource

extension UserListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.userCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UserTableViewCell
        
        cell.updateUI(viewModel: userListViewModel.userCellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = userListViewModel.userCellViewModels[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.userId = viewModel.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension UserListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        userListViewModel.filterUserBy(searchText)
    }
}
