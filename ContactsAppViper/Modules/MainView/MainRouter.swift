//
//  MainRouter.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 27/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation

final class MainRouter {
    
    private weak var delegate: MainRouterDelegate?
    
    init(delegate: MainRouterDelegate?) {
        self.delegate = delegate
    }
    
    func showDetailsView(transporter: Transporter<Any>) {
        let detailView = ContactDetailView.instantiateFromStoryboard()
        detailView.setup(transporter: transporter)
        delegate?.navigationController?.pushViewController(detailView, animated: true)
    }
}
