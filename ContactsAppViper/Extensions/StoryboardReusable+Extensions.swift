//
//  StoryboardReusable+Extensions.swift
//  ContactsAppViper
//
//  Created by Bruno Augusto on 28/08/20.
//  Copyright © 2020 Bruno Augusto. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: Reusable {}
public extension Reusable where Self: UIViewController {
    static func loadXib(from bundle: Bundle?) -> Self {
        return Self(nibName: Self.reuseIdentifier, bundle: bundle)
    }
    
    static func instantiateFromStoryboard(with name: String, in bundle: Bundle) -> Self {
        return UIStoryboard(name: name, bundle: bundle).instantiateViewController(Self.self)
    }
}

public extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        
        guard let viewController = instantiateViewController(withIdentifier: type.reuseIdentifier) as? T else {
            fatalError("View Controller not found!")
        }
        
        return viewController
    }
}

extension Reusable where Self: UIViewController {
    
    static var storyboardNameSuffix: String {
        return "View"
    }
    
    static var storyboardName: String {
        
        guard Self.storyboardNameSuffix.count < Self.reuseIdentifier.count else {
            return Self.reuseIdentifier
        }
        
        let suffix = Self.reuseIdentifier.suffix(Self.storyboardNameSuffix.count)
        guard Self.storyboardNameSuffix == suffix else {
            return Self.reuseIdentifier
        }
        
        let name = String(Self.reuseIdentifier.prefix(Self.reuseIdentifier.count - Self.storyboardNameSuffix.count))
        return name
    }
    
    static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboard(with: storyboardName, in: Bundle.getBundle(for: Self.self))
    }
}

extension Bundle {
    
    class func getBundle(for componentClass: AnyClass) -> Bundle {
        if let bundle = Bundle(identifier: "bruno.constantino.ContactsAppViper") {
            return bundle
        }
        
        return Bundle(for: componentClass.self)
    }
}
