//
//  MainInteractor.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation
import Contacts

final class MainInteractor {
    
    private weak var delegate: MainInteractorDelegate?
    private var contacts = [ContactItem]()
    
    init(delegate: MainInteractorDelegate?) {
        self.delegate = delegate
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                self.delegate?.accessDenied()
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                self.contacts = []
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        var contactsPhone: [String] = []
                        for eachNumber in contact.phoneNumbers {
                            contactsPhone.append(eachNumber.value.stringValue)
                        }
                        let email = (contact.emailAddresses.first?.value ?? "") as String
                        self.contacts.append(ContactItem(firstName: contact.givenName, lastName: contact.familyName, telephones: contactsPhone, email: email))
                        
                    })
                    self.delegate?.sucessfullyFetched(list: self.contacts)
                } catch let error {
                    print("Failed to enumerate contact", error)
                    self.delegate?.errorFetching()
                }
            } else {
                print("access denied")
                self.delegate?.errorFetching()
            }
        }
    }
}
