//
//  ContactDetailTests.swift
//  ContactsAppViperTests
//
//  Created by Bruno Augusto on 28/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import XCTest
@testable import ContactsAppViper

class ContactDetailTests: XCTestCase {
    
    // MARK: - Private Properties

    private lazy var navigationMock: UINavigationControllerMock = {
        UINavigationControllerMock()
    }()

    private lazy var routerMock: RouterMock = {
        RouterMock(navigation: navigationMock)
    }()

    private lazy var presenter: ContactDetailPresenter = {
        .init(delegate: nil, routerDelegate: routerMock)
    }()
    
    override func setUp() {
        presenter.setup(transporter: Transporter(data: getTransporter()))
        navigationMock.resetFlags()
    }
    
    func testValidateNumberOfSections() {
        XCTAssertEqual(presenter.numberOfSections(), 2)
    }
    
    func testValidateNumberOfRows() {
        XCTAssertEqual(presenter.numberOfRows(at: 0), 2)
        XCTAssertEqual(presenter.numberOfRows(at: 1), 1)
    }
    
    func testGetSubsectionTitle() {
        XCTAssertEqual(presenter.getSubsectionTitle(at: 0), "Phone")
    }
    
    func testGetName() {
        XCTAssertEqual(presenter.getName(), "Bruno")
    }
    
    func testGetLastName() {
        XCTAssertEqual(presenter.getLastName(), "Constantino")
    }
    
    func testGetPhoneNumber() {
        XCTAssertEqual(presenter.getPhoneNumber(at: 0), "+55 11 993297253")
        XCTAssertEqual(presenter.getPhoneNumber(at: 1), "+55 11 993297253")
    }
    
    func testGetPhoneNumberNotInArray() {
        XCTAssertNotEqual(presenter.getPhoneNumber(at: 2), "+55 11 993297253")
        XCTAssertEqual(presenter.getPhoneNumber(at: 2), "")
    }
    
    func testGetEmail() {
        XCTAssertEqual(presenter.getEmail(), "bconst123@gmail.com")
    }
}

extension ContactDetailTests {
    private func getTransporter() -> ContactDetailTransporter {
        return .init(contact: ContactItem(firstName: "Bruno", lastName: "Constantino", telephones: ["+55 11 993297253", "+55 11 993297253"], email: "bconst123@gmail.com"))
    }
}

// MARK: - RouterMock

private class RouterMock: ContactDetailRouterDelegate {

    var navigationController: UINavigationController?

    init(navigation: UINavigationControllerMock) {
        navigationController = navigation
    }
}
