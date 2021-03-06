//
//  NSObjectExtension.swift
//  Suift
//
//  Created by Yudai.Hirose on 2018/07/18.
//  Copyright © 2018年 廣瀬雄大. All rights reserved.
//

import Foundation

extension NSObject {
    public static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
