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

extension UIView: Reusable {}
public extension Reusable where Self: UIView {
    func nib<T: UIView>(_ type: T.Type, bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: type.reuseIdentifier, bundle: bundle)
    }
}

public extension Reusable where Self: UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(of type: T.Type) {
        registerCell(of: type, bundle: Bundle(for: T.self))
    }
    
    func registerCell<T: UICollectionViewCell>(of type: T.Type, bundle: Bundle?) {
        register(nib(type, bundle: bundle), forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerCellFromClass<T: UICollectionViewCell>(of type: T.Type) {
        register(type, forCellWithReuseIdentifier:  type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }
}

public extension Reusable where Self: UITableView {
    
    func registerHeaderViewFromClass<T: UIView>(of type: T.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerHeaderView<T: UIView>(of type: T.Type, bundle: Bundle? = nil) {
        register(nib(type, bundle: bundle), forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerCellFromClass<T: UITableViewCell>(of type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerCell<T: UITableViewCell>(of type: T.Type, bundle: Bundle? = nil) {
        register(nib(type, bundle: bundle), forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            return T(style: .default, reuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableHeader<T: UIView>(_ type: T.Type) -> T {
         if let view = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? T {
             return view
         } else {
             return T()
         }
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
