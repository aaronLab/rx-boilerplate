//
//  UITableViewCell+Ext.swift
//
//  Created by Aaron Lee on 2021/07/23.
//

import UIKit

extension UITableViewCell {
    
    /// 에디팅 이미지
    var reorderControlImageView: UIImageView? {
        let reorderControl = self.subviews.first { view -> Bool in
            view.classForCoder.description() == "UITableViewCellReorderControl"
        }
        return reorderControl?.subviews.first { view -> Bool in
            view is UIImageView
        } as? UIImageView
    }
    
    /// 에디팅 이미지 변경
    func setReorderImage(image: UIImage?) {
        reorderControlImageView?.image = image
        
        reorderControlImageView?.contentMode = .right
        
        reorderControlImageView?.frame.size.width = bounds.height
        reorderControlImageView?.frame.size.height = bounds.height
    }
    
}
