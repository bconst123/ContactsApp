//
//  MainPresenter.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//
// To run these tests you need to accept contacts access permission first

import Foundation

final class MainPresenter {
    
    private lazy var interactor: MainInteractor = .init(delegate: self)
    private weak var delegate: MainPresenterDelegate?
    private var router: MainRouter?
    private (set) var contacts = [ContactItem]()
    private (set) var filteredContacts: [ContactItem] = []
    private (set) var userAccessDenied = false
    
    private var transporter: MainTransporter?
    
    init(delegate: MainPresenterDelegate?, routerDelegate: MainRouterDelegate?) {
        self.delegate = delegate
        router = .init(delegate: routerDelegate)
    }
    
    func setup(transporter: Transporter<Any>) {
        self.transporter = transporter.data as? MainTransporter
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(at section: Int) -> Int {
        if isAccessDenied() {
            return 1
        }
        if section == 0 {
            return contacts.count
        } else {
            return 0
        }
    }
    
    func isAccessDenied() -> Bool {
        return userAccessDenied
    }
    
    func numberOfFilteredRows(at section: Int) -> Int {
        return filteredContacts.count
    }
    
    func loadContacts() {
        contacts.removeAll()
        interactor.fetchContacts()
    }
    
    func getContactName(for index: Int) -> String {
        return contacts[index].firstName + " " + contacts[index].lastName
    }
    
    func getContactFilteredName(for index: Int) -> String {
        return filteredContacts[index].firstName + " " + filteredContacts[index].lastName
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredContacts = self.contacts.filter { (eachContact: ContactItem) -> Bool in
            return (eachContact.firstName.lowercased() + " " + eachContact.lastName.lowercased()).contains(searchText.lowercased())
        }
        delegate?.didLoad()
    }
    
    func showContactDetails(at index: Int, isFiltering: Bool) {
        let contact = isFiltering ? filteredContacts[index] : contacts[index]
        router?.showDetailsView(transporter: Transporter(data: ContactDetailTransporter(contact: contact)))
    }
    
    func getAccessDeniedTitle() -> String {
        return "Enable contacts access"
    }
}

// MARK: - MainInteractorDelegate

extension MainPresenter: MainInteractorDelegate {
    func sucessfullyFetched(list: [ContactItem]) {
        self.contacts = list
        delegate?.didLoad()
    }
    
    func errorFetching() {
        delegate?.errorLoading()
    }
    
    func accessDenied() {
        userAccessDenied = true
        delegate?.didLoad()
    }
}
