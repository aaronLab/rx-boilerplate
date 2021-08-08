//
//  UIImage+Ext.swift
//
//  Created by Aaron Lee on 2021/05/21.
//

import UIKit

extension UIImage {
    
    /// 앱 이미지 반환
    static func appImage(_ name: Constants.Images) -> UIImage? {
        return UIImage(named: name.rawValue)?
            .withRenderingMode(.alwaysOriginal)
    }
    
    /// 앱 아이콘 반환
    static func appIcon(_ name: Constants.Icons) -> UIImage? {
        return UIImage(named: name.rawValue)?
            .withRenderingMode(.alwaysOriginal)
    }
    
}
