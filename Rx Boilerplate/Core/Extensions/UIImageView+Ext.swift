//
//  UIImageView+Ext.swift
//
//  Created by Aaron Lee on 2021/05/21.
//

import UIKit

extension UIImageView {
    
    /// 이미지뷰 이미지 전환
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
                            DispatchQueue.main.async {
                                self.image = image
                            }
                          })
    }
    
    /// 프로필 썸네일 스타일
    func stylingProfileImage() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 100 / 2
        snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
    }
    
}
