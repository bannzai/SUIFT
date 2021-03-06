//
//  Color.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/03.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import UIKit

public protocol Colorable: WrapperForEquatable {
    var color: UIColor { get }
}

extension UIColor: Colorable {
    public var color: UIColor {
        return self
    }
}

public struct Color {
    public struct RGB: Colorable {
        public let red: CGFloat
        public let green: CGFloat
        public let blue: CGFloat
        public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
            self.red = red
            self.green = green
            self.blue = blue
        }

        public var color: UIColor {
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
    
    public struct RGBA: Colorable {
        public let red: CGFloat
        public let green: CGFloat
        public let blue: CGFloat
        public let alpha: CGFloat
        public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
        
        public var color: UIColor {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}

extension Color.RGB: SuiftEquatable {
    public static func == (lhs: Color.RGB, rhs: Color.RGB) -> Bool {
        return lhs.red == rhs.red &&
            lhs.green == rhs.green &&
            lhs.blue == rhs.blue
    }
}

extension Color.RGBA: SuiftEquatable {
    public static func == (lhs: Color.RGBA, rhs: Color.RGBA) -> Bool {
        return lhs.red == rhs.red &&
            lhs.green == rhs.green &&
            lhs.blue == rhs.blue &&
            lhs.alpha == rhs.alpha
    }
}

