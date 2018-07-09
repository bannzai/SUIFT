//
//  CollectionViewItem.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/09.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import UIKit

public protocol CollectionViewItem: Reusable {
    
}

public protocol CollectionViewItemDelegatable {
    func configureCell(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
    func size(for collectionView: UICollectionView, indexPath: IndexPath) -> CGSize?
    
    func canMoveItem(collectionView: UICollectionView, indexPath: IndexPath) -> Bool?
    
    func willDisplay(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
    func didEndDisplay(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
    
    func shouldHighlight(collectionView: UICollectionView, indexPath: IndexPath) -> Bool?
    func didHighlight(collectionView: UICollectionView, indexPath: IndexPath)
    func didUnhighlight(collectionView: UICollectionView, indexPath: IndexPath)
    
    func shouldSelect(collectionView: UICollectionView, indexPath: IndexPath) -> Bool?
    func shouldDeselect(collectionView: UICollectionView, indexPath: IndexPath) -> Bool?
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
    func didDeselect(collectionView: UICollectionView, indexPath: IndexPath)
    
    func shouldShowMenu(collectionView: UICollectionView, indexPath: IndexPath) -> Bool?
    func canPerformAction(collectionView: UICollectionView, action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool?
    func performAction(collectionView: UICollectionView, action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
}


public struct CollectionViewItemImpl<Cell: UICollectionViewCell>: CollectionViewItem {
    public typealias ItemArgument = (item: CollectionViewItemImpl<Cell>, collectionView: UICollectionView, indexPath: IndexPath)
    public typealias PerformActionArgument = (item: CollectionViewItemImpl<Cell>, collectionView: UICollectionView, action: Selector, indexPath: IndexPath, sender: Any?)
    
    
    public let identifier: String
    
    public var configureCell: ((Cell, ItemArgument) -> Void)?
    public var sizeFor: ((ItemArgument) -> CGSize)?
    
    public var canMoveItem: ((ItemArgument) -> Bool)?
    
    public var willDisplay: ((Cell, ItemArgument) -> Void)?
    public var didEndDisplay: ((Cell, ItemArgument) -> Void)?
    
    public var shouldHighlight: ((ItemArgument) -> Bool)?
    public var didHighlight: ((ItemArgument) -> Void)?
    public var didUnhighlight: ((ItemArgument) -> Void)?
    
    public var shouldSelect: ((ItemArgument) -> Bool)?
    public var shouldDeselect: ((ItemArgument) -> Bool)?
    public var didSelect: ((ItemArgument) -> Void)?
    public var didDeselect: ((ItemArgument) -> Void)?
    
    public var shouldShowMenu: ((ItemArgument) -> Bool)?
    public var canPerformAction: ((PerformActionArgument) -> Bool)?
    public var performAction: ((PerformActionArgument) -> Void)?
}

extension CollectionViewItemImpl {
    public func register() {
        
    }
}


extension CollectionViewItemImpl: CollectionViewItemDelegatable {
    public func configureCell(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        configureCell?(cell as! Cell, (self, collectionView, indexPath))
    }
    
    public func size(for collectionView: UICollectionView, indexPath: IndexPath) -> CGSize? {
        return sizeFor?((self, collectionView, indexPath))
    }
    
    public func canMoveItem(collectionView: UICollectionView, indexPath: IndexPath) -> Bool? {
        return canMoveItem?((self, collectionView, indexPath))
    }
    
    public func willDisplay(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        willDisplay?(cell as! Cell, (self, collectionView, indexPath))
    }
    
    public func didEndDisplay(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        didEndDisplay?(cell as! Cell, (self, collectionView, indexPath))
    }
    
    public func shouldHighlight(collectionView: UICollectionView, indexPath: IndexPath) -> Bool? {
        return shouldHighlight?((self, collectionView, indexPath))
    }
    
    public func didHighlight(collectionView: UICollectionView, indexPath: IndexPath) {
        didHighlight?((self, collectionView, indexPath))
    }
    
    public func didUnhighlight(collectionView: UICollectionView, indexPath: IndexPath) {
        didUnhighlight?((self, collectionView, indexPath))
    }
    
    public func shouldSelect(collectionView: UICollectionView, indexPath: IndexPath) -> Bool? {
        return shouldSelect?((self, collectionView, indexPath))
    }
    
    public func shouldDeselect(collectionView: UICollectionView, indexPath: IndexPath) -> Bool? {
        return shouldDeselect?((self, collectionView, indexPath))
    }
    
    public func didSelect(collectionView: UICollectionView, indexPath: IndexPath) {
        didSelect?((self, collectionView, indexPath))
    }
    
    public func didDeselect(collectionView: UICollectionView, indexPath: IndexPath) {
        didDeselect?((self, collectionView, indexPath))
    }
    
    public func shouldShowMenu(collectionView: UICollectionView, indexPath: IndexPath) -> Bool? {
        return shouldShowMenu?((self, collectionView, indexPath))
    }
    
    public func canPerformAction(collectionView: UICollectionView, action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool? {
        return canPerformAction?((self, collectionView, action, indexPath, sender))
    }
    
    public func performAction(collectionView: UICollectionView, action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        performAction?((self, collectionView, action, indexPath, sender))
    }
}
