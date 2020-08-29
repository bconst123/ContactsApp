//
//  MainTests.swift
//  ContactsAppViperTests
//
//  Created by Bruno Augusto on 28/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import XCTest
@testable import ContactsAppViper

class MainTests: XCTestCase {
    
    // MARK: - Private Properties

    private lazy var navigationMock: UINavigationControllerMock = {
        UINavigationControllerMock()
    }()

    private lazy var routerMock: RouterMock = {
        RouterMock(navigation: navigationMock)
    }()

    private lazy var presenter: MainPresenter = {
        .init(delegate: nil, routerDelegate: routerMock)
    }()
    
    override func setUp() {
        presenter.setup(transporter: Transporter(data: getTransporter()))
        presenter.loadContacts()
        navigationMock.resetFlags()
    }
    
    func testValidateNumberOfSections() {
        XCTAssertEqual(presenter.numberOfSections(), 1)
    }
    
    func testValidateNumberOfRows() {
        XCTAssertEqual(presenter.numberOfRows(at: 0), 6)
    }
    
    func testValidateNumberOfRowsAtInvalidSection() {
        XCTAssertEqual(presenter.numberOfRows(at: 1), 0)
        XCTAssertEqual(presenter.numberOfRows(at: 99), 0)
    }
    
    func testGetContactName() {
        // depends on the contacts of your mock Contacts App
        XCTAssertEqual(presenter.getContactName(for: 2), "John Appleseed")
    }
    
    func testValidateShowContactDetails() {
        presenter.showContactDetails(at: 0, isFiltering: false)
        XCTAssertTrue(navigationMock.pushViewControllerCalled)
    }
    
    func testGetAccessDeniedTitle() {
        XCTAssertEqual(presenter.getAccessDeniedTitle(), "Enable contacts access")
    }
}

extension MainTests {
    private func getTransporter() -> MainTransporter {
        return .init()
    }
}

// MARK: - RouterMock

private class RouterMock: MainRouterDelegate {

    var navigationController: UINavigationController?

    init(navigation: UINavigationControllerMock) {
        navigationController = navigation
    }
}
