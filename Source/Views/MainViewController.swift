//
//  MainViewController.swift
//  Functional
//
//  Created by Adriano Soares on 23/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import Cartography
import ReactiveSwift
import ReactiveCocoa
import Runes

class MainViewController: UIViewController {

    let tableView = UITableView()
    let searchBar = UISearchBar()
    let userView  = UserView()

    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        searchBar.reactive.text <~ viewModel.searchText

        searchBar.reactive.continuousTextValues.skipNil().observeValues { text in
            self.viewModel.searchText.value = text
        }

        self.viewModel.repos.signal.observeValues { _ in
            self.tableView.reloadData()
        }

        self.viewModel.user.signal.observeValues { user in
            self.userView.user.swap(user)
        }

        setupConstraints()
        setupStyles()

    }

    func setupViews () {
        automaticallyAdjustsScrollViewInsets = false

        tableView.delegate   = self
        tableView.dataSource = self
        view.addSubview(tableView)

        searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        view.addSubview(searchBar)

        view.addSubview(userView)
    }

    func setupConstraints () {
        constrain(tableView, searchBar, userView) { tableView, searchBar, userView in
            if let superView = searchBar.superview {
                searchBar.top    == topLayoutGuideCartography
                searchBar.left   == superView.left
                searchBar.right  == superView.right
                searchBar.height == 50
            }

            if let superView = userView.superview {
                userView.top     == searchBar.bottom
                userView.left    == superView.left
                userView.right   == superView.right
                userView.height  == 100
            }

            if let superView = tableView.superview {
                tableView.top    == userView.bottom
                tableView.bottom == bottomLayoutGuideCartography
                tableView.left   == superView.left
                tableView.right  == superView.right
            }
        }
    }

    func setupStyles () {
        navigationItem.title = "Repositories"
        if let navigationBar = navigationController?.navigationBar {
            LayoutManager.shared.styleNavigationBar(navigationBar: navigationBar)
        }

        searchBar.barTintColor = LayoutManager.shared.navigationColor

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.value.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = viewModel.repos.value[indexPath.row].fullName

        return cell
    }
}
