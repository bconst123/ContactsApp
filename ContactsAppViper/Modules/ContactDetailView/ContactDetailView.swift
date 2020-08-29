//
//  ContactDetailView.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import UIKit

final class ContactDetailView: UIViewController {
    
    lazy var presenter: ContactDetailPresenter = .init(delegate: self, routerDelegate: self)
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = ContactDetailConstants.Strings.viewTitle
    }
    
    func setup(transporter: Transporter<Any>) {
        presenter.setup(transporter: transporter)
    }
    
    func setupName() {
        nameLabel.text = presenter.getName()
        lastNameLabel.text = presenter.getLastName()
    }
}

// MARK: - MainPresenterDelegate

extension ContactDetailView: ContactDetailPresenterDelegate {}

// MARK: - MainRouterDelegate

extension ContactDetailView: ContactDetailRouterDelegate {}

// MARK: - UITableViewDelegate/DataSource

extension ContactDetailView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailConstants.Strings.cellIdentifier, for: indexPath)
        if indexPath.section == 1 {
            cell.textLabel?.text = presenter.getEmail()
        } else {
            cell.textLabel?.text = presenter.getPhoneNumber(at: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getSubsectionTitle(at: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
