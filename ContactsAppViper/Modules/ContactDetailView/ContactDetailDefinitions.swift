//
//  ContactDetailDefinitions.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MAinView Protocols

protocol ContactDetailInteractorDelegate: class {}

protocol ContactDetailPresenterDelegate: class {}

protocol ContactDetailRouterDelegate: class {
    var navigationController: UINavigationController? { get }
}

// MARK: - Main Data Source

struct ContactDetailTransporter {
    var contact: ContactItem
}

struct ContactDetailConstants {
    struct Strings {
        static let viewTitle = "Contact Details"
        static let cellIdentifier = "cell"
        static let phoneTitle = "Phone"
        static let emailTitle = "Email"
    }
    struct Constraints {
        static let topSpace: CGFloat = 10
    }
}
