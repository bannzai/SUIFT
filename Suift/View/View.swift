//
//  View.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/02.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import Foundation

public struct ViewStyle: Style {
    public var backgroundColor: Colorable?
    
    public init() { }
    
    public func apply(with view: UIView) {
        view.backgroundColor = backgroundColor?.color
    }
}

public struct View<V: UIView>: Viewable {
    let _view: V
    
    public let style: ViewStyle
    public let constraint: LayoutMaker
    public let children: [Viewable]
    
    public init(
        view: V? = nil,
        style: ViewStyle,
        constraint: LayoutMaker,
        children: [Viewable] = []
        ) {
        if let view = view {
            self._view = view
        } else {
            self._view = V()
        }
        self.style = style
        self.constraint = constraint
        self.children = children
    }
    
    public func view() -> UIView {
        return _view
    }
}
