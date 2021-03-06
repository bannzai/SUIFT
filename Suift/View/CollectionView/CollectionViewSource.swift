//
//  CollectionViewSource.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/09.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import Foundation

public class CollectionViewSource: NSObject {
    public weak var collectionView: UICollectionView? {
        didSet {
            if let collectionView = collectionView {
                setup(for: collectionView)
            }
        }
    }
    public var sections: [CollectionViewSection]
    
    public var didMoveItem: ((_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)?
    public var indexTitles: ((UICollectionView) -> [String])?
    public var indexTitle: ((_ collectionView: UICollectionView, _ title: String, _ index: Int) -> IndexPath)?

    public init(
        sections: [CollectionViewSection],
        
        didMoveItem: ((_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)? = nil,
        indexTitles: ((UICollectionView) -> [String])? = nil,
        indexTitle: ((_ collectionView: UICollectionView, _ title: String, _ index: Int) -> IndexPath)? = nil
        ) {
        self.sections = sections
        
        self.didMoveItem = didMoveItem
        self.indexTitles = indexTitles
        self.indexTitle = indexTitle

        super.init()
    }
    
    public init<E>(
        elements: [E],

        didMoveItem: ((_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void)? = nil,
        indexTitles: ((UICollectionView) -> [String])? = nil,
        indexTitle: ((_ collectionView: UICollectionView, _ title: String, _ index: Int) -> IndexPath)? = nil,
        
        sectionsClosure: ((E) -> [CollectionViewSection])
        ) {
        self.sections = elements.flatMap { sectionsClosure($0) }

        self.didMoveItem = didMoveItem
        self.indexTitles = indexTitles
        self.indexTitle = indexTitle
        
        super.init()
    }
}

extension CollectionViewSource: CollectionViewReloadable {
    public func reload() {
        collectionView?.reloadData()
    }
}

internal extension CollectionViewSource {
    func setup(for collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        sections
            .flatMap { $0.items.map { $0 } }
            .forEach { $0.register(to: collectionView) }
        
    }
    
    func item(for indexPath: IndexPath) -> CollectionViewItem {
        return sections[indexPath.section].items[indexPath.item]
    }
}
