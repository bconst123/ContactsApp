//
//  ContactDetailInteractor.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation

final class ContactDetailInteractor {
    
    private weak var delegate: ContactDetailInteractorDelegate?
    
    init(delegate: ContactDetailInteractorDelegate?) {
        self.delegate = delegate
    }
}
