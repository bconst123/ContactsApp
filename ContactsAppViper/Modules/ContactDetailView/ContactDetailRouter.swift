//
//  ContactDetailRouter.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation

final class ContactDetailRouter {
    
    private weak var delegate: ContactDetailRouterDelegate?
    
    init(delegate: ContactDetailRouterDelegate?) {
        self.delegate = delegate
    }
}
