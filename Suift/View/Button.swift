//
//  Button.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/05.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import UIKit

public struct ButtonStyle: Style {
    var state: UIControlState = .normal
    public var viewStyle: ViewStyle?
    public var labelStyle: LabelStyle?
    
    public init() { }
    public func apply(with button: UIButton) {
        button.backgroundColor = viewStyle?.backgroundColor?.color
        
        if let labelStyle = labelStyle {
            button.titleLabel?.textColor = labelStyle.textColor?.color ?? button.titleColor(for: state)
        }
    }
}

extension ButtonStyle: SuiftEquatable {
    public static func == (lhs: ButtonStyle, rhs: ButtonStyle) -> Bool {
        return lhs.viewStyle == rhs.viewStyle && lhs.viewStyle == rhs.viewStyle
    }
}

public class ButtonDelegate {
    public var closure: ((UIButton) -> Void)?
    @objc func done(button: UIButton) {
        closure?(button)
    }
}

public class ButtonEvent {
    public let events: UIControlEvents
    public let closure: ((UIButton) -> Void)
    
    public init(
        events: UIControlEvents,
        closure: @escaping ((UIButton) -> Void)
        ) {
        self.events = events
        self.closure = closure
    }
}

extension UIButton {
    struct AssociatedObjectHandle {
        static var delegate: UInt8 = 0
    }
    var delegate: ButtonDelegate {
        get {
            let delegate = objc_getAssociatedObject(self, &UIButton.AssociatedObjectHandle.delegate) as? ButtonDelegate
            switch delegate {
            case let delegate?:
                return delegate
            case nil:
                let delegate = ButtonDelegate()
                objc_setAssociatedObject(self, &UIButton.AssociatedObjectHandle.delegate, delegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return delegate
            }
        }
    }
    func register(event: ButtonEvent) {
        delegate.closure = { event.closure($0) }
        addTarget(delegate, action: #selector(ButtonDelegate.done(button:)), for: .touchUpInside)
    }
}

public struct Button<V: UIButton>: Rootable {
    let _button: V
    
    public let style: ButtonStyle
    public let constraint: LayoutMaker
    public let children: [ViewChildable]
    public let delegate: ButtonDelegate
    
    public init(
        button: V? = nil,
        style: ButtonStyle,
        constraint: LayoutMaker,
        event: ButtonEvent,
        children: [ViewChildable] = []
        ) {
        if let button = button {
            self._button = button
        } else {
            self._button = V(type: .custom)
        }
        self.style = style
        self.constraint = constraint
        self.children = children
        self.delegate = ButtonDelegate()

        _button.register(event: event)
    }

    public func stylize(for view: UIView) {
        style.apply(with: view as! V)
    }

    public func view() -> UIView {
        return _button
    }
}
