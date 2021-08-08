//
//  UIStackView+Ext.swift
//
//  Created by Aaron Lee on 2021/05/24.
//

import UIKit
import SnapKit

extension UIStackView {
    
    /// 패딩 추가
    func addInset(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        isLayoutMarginsRelativeArrangement = true
    }
    
    /// 백그라운드 추가(OS 버전 분기처리)
    func backgroundColor(color: UIColor?, cornerRadius: CGFloat = 0) {
        if #available(iOS 14.0, *) {
            backgroundColor = color
        } else {
            let backgroundColorView = UIView(frame: .zero)
            backgroundColorView.backgroundColor = color
            backgroundColorView.restorationIdentifier = "stackviewColorBackground"
            backgroundColorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundColorView.layer.cornerRadius = cornerRadius
            addSubview(backgroundColorView)
            
            backgroundColorView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    /// 셋업
    func setupStackView(axis: NSLayoutConstraint.Axis,
                        spacing: CGFloat = 16,
                        distribution: Distribution = .fill,
                        alignment: Alignment = .fill) {
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
    
    /// 그림자 추가
    func applyShadow(color: UIColor? = .appColor(.black),
                     alpha: Float = 0.03,
                     x: CGFloat = 0,
                     y: CGFloat = 4,
                     blur: CGFloat = 4) {
        if #available(iOS 14.0, *) {
            layer.applyShadow()
        } else {
            let backgroundView = subviews.filter { $0.restorationIdentifier == "stackviewColorBackground" }.first
            backgroundView?.layer.applyShadow(color: color, alpha: alpha, x: x, y: y, blur: blur)
        }
    }
    
}
