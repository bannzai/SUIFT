//
//  AttributedTextable.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/03.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import Foundation

public protocol AttributedTextable {
    var attributedText: NSAttributedString { get }
}

public struct AttributedText: AttributedTextable {
    public let text: String
    public let styles: [AttributeStyle]
    
    public var attributedText: NSAttributedString {
        return NSAttributedString(string: text, attributes: styles.attributes())
    }
}

fileprivate extension Array where Element == AttributeStyle {
    func attributes() -> [NSAttributedStringKey: Any] {
        return reduce(into: [NSAttributedStringKey: Any]()) { (result, element) in
            let key = element.key
            let value = element.attributes[key]!
            result.updateValue(value, forKey: key)
        }
    }
}
