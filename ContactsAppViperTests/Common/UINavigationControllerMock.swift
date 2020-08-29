//
//  UINavigationControllerMock.swift
//  ContactsAppViperTests
//
//  Created by Bruno Augusto on 28/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import UIKit

class UINavigationControllerMock: UINavigationController {

    // MARK: - Public Properties

    var dismissCalled: Bool = false
    var pushViewControllerCalled: Bool = false

    // MARK: - Overrides

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: false, completion: completion)
        dismissCalled = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
        pushViewControllerCalled = true
    }

    func resetFlags() {
        dismissCalled = false
        pushViewControllerCalled = false
    }
}

