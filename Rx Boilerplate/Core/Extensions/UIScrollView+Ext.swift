//
//  UIScrollView+Ext.swift
//
//  Created by Aaron Lee on 2021/07/30.
//

import UIKit

extension UIScrollView {
    
    /// 최하단 도달
    var reachedToBottom: Bool {
        return contentOffset.y >= scrolledOffset
    }
    
    /// 스크롤된 Offset
    var scrolledOffset: CGFloat {
        return contentSize.height - frame.size.height
    }
    
    /// Threshold 도달
    func reachedThreshold(thresholdOffset: CGFloat) -> Bool {
        
        return contentOffset.y >= scrolledOffset - thresholdOffset
    }
    
}
