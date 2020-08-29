//
//  ContactDetailPresenter.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation

final class ContactDetailPresenter {
    
    private lazy var interactor: ContactDetailInteractor = .init(delegate: self)
    private weak var delegate: ContactDetailPresenterDelegate?
    private var router: ContactDetailRouter?
    
    private var transporter: ContactDetailTransporter?
    
    init(delegate: ContactDetailPresenterDelegate?, routerDelegate: ContactDetailRouterDelegate?) {
        self.delegate = delegate
        router = .init(delegate: routerDelegate)
    }
    
    func numberOfSections() -> Int {
        if let email = transporter?.contact.email, email != "" {
            return 2
        } else {
            return 1
        }
    }
    
    func numberOfRows(at section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return self.transporter?.contact.telephones.count ?? 0
    }
    
    func setup(transporter: Transporter<Any>) {
        self.transporter = transporter.data as? ContactDetailTransporter
    }
    
    func getSubsectionTitle(at index: Int) -> String {
        return index == 0 ? ContactDetailConstants.Strings.phoneTitle : ContactDetailConstants.Strings.emailTitle
    }
    
    func getName() -> String {
        return self.transporter?.contact.firstName ?? ""
    }
    
    func getLastName() -> String {
        return self.transporter?.contact.lastName ?? ""
    }
    
    func getPhoneNumber(at index: Int) -> String {
        if let phoneNumbers =  self.transporter?.contact.telephones, index < phoneNumbers.count {
            return phoneNumbers[index]
        }
        return ""
    }
    
    func getEmail() -> String {
        return self.transporter?.contact.email ?? ""
    }
}

// MARK: - MainInteractorDelegate

extension ContactDetailPresenter: ContactDetailInteractorDelegate {
    
}
