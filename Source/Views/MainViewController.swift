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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let tableView = UITableView()
    let searchBar = UISearchBar()
    let userView  = UserView()

    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()

        self.searchBar.reactive.text <~ self.viewModel.searchText

        self.searchBar.reactive.continuousTextValues.skipNil().observeValues { text in
            self.viewModel.searchText.value = text
        }

        self.viewModel.repos.signal.observeValues { _ in
            self.tableView.reloadData()
        }

        self.setupConstraints()
        self.setupStyles()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repos.value.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = self.viewModel.repos.value[indexPath.row].fullName

        return cell
    }

    func setupViews () {
        self.automaticallyAdjustsScrollViewInsets = false

        self.tableView.delegate   = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)

        self.searchBar.delegate = self
        self.searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        self.view.addSubview(searchBar)

        self.view.addSubview(userView)

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
                userView.top    == searchBar.bottom
                userView.left   == superView.left
                userView.right  == superView.right
                userView.height == 100
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
        self.navigationItem.title = "Repositories"
        if let navigationBar = self.navigationController?.navigationBar {
            LayoutManager.shared.styleNavigationBar(navigationBar: navigationBar)
        }

        self.searchBar.barTintColor = LayoutManager.shared.navigationColor

    }
}
