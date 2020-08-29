//
//  MainDefinitions.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation
import UIKit

struct ContactItem {
    var firstName: String
    var lastName: String
    var telephones: [String]
    var email: String
}

// MARK: - MAinView Protocols

protocol MainInteractorDelegate: class {
    func sucessfullyFetched(list: [ContactItem])
    func accessDenied()
    func errorFetching()
}

protocol MainPresenterDelegate: class {
    func didLoad()
    func errorLoading()
}

protocol MainRouterDelegate: class {
    var navigationController: UINavigationController? { get }
}

// MARK: - Main Data Source

struct MainTransporter {

}

struct MainConstants {
    struct Strings {
        static let viewTitle = "Contacts"
        static let cellIdentifier = "cell"
        static let placeHolder = "Search for contacts"
        static let errorMessage = "Error loading... \n\npull to refresh contact list"
    }
    
    struct Constraints {
        static let errorMessageHeight = 100
        static let errorMessageMarginTop = 40
    }
}
