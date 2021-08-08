//
//  UITextView+Ext.swift
//
//  Created by Aaron Lee on 2021/07/14.
//

import UIKit

extension UITextView{
    
    /// 줄 수
    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
    
}
