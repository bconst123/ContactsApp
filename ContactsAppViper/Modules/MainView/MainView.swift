//
//  MainView.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import UIKit

final class MainView: UIViewController {
    
    lazy var presenter: MainPresenter = .init(delegate: self, routerDelegate: self)
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(MainView.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadContacts()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = MainConstants.Strings.placeHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.tableView.addSubview(self.refreshControl)
        title = MainConstants.Strings.viewTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setup(transporter: Transporter<Any>) {
        presenter.setup(transporter: transporter)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.loadContacts()
        refreshControl.endRefreshing()
    }
}

// MARK: - MainPresenterDelegate

extension MainView: MainPresenterDelegate {
    func didLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func errorLoading() {
        let label = UILabel(frame: CGRect(x: 0, y: MainConstants.Constraints.errorMessageMarginTop, width: Int(self.view.bounds.width), height: MainConstants.Constraints.errorMessageHeight))
        label.numberOfLines = 0
        label.textColor = .gray
        label.text = MainConstants.Strings.errorMessage
        label.textAlignment = .center
        let labelView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.bounds.width), height: MainConstants.Constraints.errorMessageHeight))
        labelView.addSubview(label)
        tableView.addSubview(labelView)
    }
}

// MARK: - MainRouterDelegate

extension MainView: MainRouterDelegate {
    
}

// MARK: - UITableViewDelegate/DataSource

extension MainView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter.numberOfFilteredRows(at: section)
        }
        return presenter.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainConstants.Strings.cellIdentifier, for: indexPath)
        if presenter.isAccessDenied() {
            cell.textLabel?.text = presenter.getAccessDeniedTitle()
        } else if isFiltering {
            cell.textLabel?.text = presenter.getContactFilteredName(for: indexPath.row)
        } else {
            cell.textLabel?.text = presenter.getContactName(for: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.isAccessDenied() {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        } else {
            presenter.showContactDetails(at: indexPath.row, isFiltering: isFiltering)
        }
    }
}

// MARK: - UISearchResultsUpdating

extension MainView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        presenter.filterContentForSearchText(searchBar.text!)
    }
}
