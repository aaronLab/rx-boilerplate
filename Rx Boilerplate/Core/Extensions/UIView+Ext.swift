//
//  UIView+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

extension UIView {
    
    /// 폰트 적용(Apple SD Gothic Neo)
    func font(_ font: Font) {
        if let v = self as? UIButton {
            v.titleLabel?.font = .font(font)
        } else if let v = self as? UILabel {
            v.font = .font(font)
        } else if let v = self as? UITextField {
            v.font = .font(font)
        } else if let v = self as? UITextView {
            v.font = .font(font)
        } else {
            for v in subviews {
                v.font(font)
            }
        }
    }
    
    /// 특정 모서리에 radius 부여
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// 뷰 회전
    func rotate(degrees: CGFloat) {
        
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
    }
    
    /// 회전
    func startRotating(duration: CFTimeInterval = Constants.animationDefaultDuration,
                       repeatCount: Float = Float.infinity,
                       clockwise: Bool = true) {
        
        if self.layer.animation(forKey: "transform.rotation.z") != nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let direction = clockwise ? 1.0 : -1.0
        animation.toValue = NSNumber(value: .pi * 2 * direction)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = repeatCount
        self.layer.add(animation, forKey:"transform.rotation.z")
    }
    
    /// 회전 중지
    func stopRotating() {
        
        self.layer.removeAnimation(forKey: "transform.rotation.z")
        
    }
    
    /// 그라데이션
    func applyGradient(colors: [UIColor?]?) {
        let colors = colors?.filter({ $0 != nil }).map({ $0!.cgColor })
        
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    /// Show 애니메이션
    func show(duration: Double = Constants.transitionDefaultDuration, animated: Bool = true, completion: (() -> Void)? = nil) {
        if alpha == 1 { return }
        
        if !animated {
            alpha = 1
            completion?()
            return
        }
        
        UIView.animateKeyframes(withDuration: Constants.transitionDefaultDuration,
                                delay: 0.3,
                                options: [.allowUserInteraction]) {
            self.alpha = 1
        } completion: { _ in
            completion?()
        }
        
    }
    
    /// Hide 애니메이션
    func hide(duration: Double = Constants.transitionDefaultDuration, animated: Bool = true, completion: (() -> Void)? = nil) {
        if alpha == 0 { return }
        
        if !animated {
            alpha = 0
            completion?()
            return
        }
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: [.allowUserInteraction]) {
            self.alpha = 0
        } completion: { _ in
            completion?()
        }
        
    }
    
    /// 애니메이션 layoutIfNeeded
    func layoutIfNeededWithAnimation(duration: Double = Constants.transitionDefaultDuration,
                                     completion: (() -> Void)? = nil) {
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: [.allowUserInteraction]) {
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }

    }
    
}
