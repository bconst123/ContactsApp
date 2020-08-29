//
//  Transporter.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation

class Transporter<T> {
    var data: T?
    
    init(data: T?) {
        self.data = data
    }
}
