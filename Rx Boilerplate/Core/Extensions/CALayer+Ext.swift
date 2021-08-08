//
//  CALayer+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

extension CALayer {
    
    /// 그림자 추가
    func applyShadow(color: UIColor? = .appColor(.black),
                     alpha: Float = 0.05,
                     x: CGFloat = 0,
                     y: CGFloat = 4,
                     blur: CGFloat = 4) {
        masksToBounds = false
        shadowColor = color?.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
    }
    
    /// 원하는 영역에만 테두리 추가
    ///
    /// view.layoutIfneeded() 이후 사용
    func addBorder(_ arr_edge: [UIRectEdge],
                   color: UIColor?,
                   width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0,
                                           y: 0,
                                           width: frame.width,
                                           height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0,
                                           y: frame.height - width,
                                           width: frame.width,
                                           height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0,
                                           y: 0,
                                           width: width,
                                           height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width,
                                           y: 0,
                                           width: width,
                                           height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = (color ?? .systemGray).cgColor
            self.addSublayer(border)
        }
    }
    
}
