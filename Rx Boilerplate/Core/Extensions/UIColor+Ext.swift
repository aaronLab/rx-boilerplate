//
//  UIColor+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

extension UIColor {
    
    /// 앱 색상 반환
    static func appColor(_ name: Constants.Colors) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
}
