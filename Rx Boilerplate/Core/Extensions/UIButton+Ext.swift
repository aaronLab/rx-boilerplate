//
//  UIButton+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

// MARK: - Custom Button Gesture

extension UIButton {
    
    /**
     This part will let you use the system default animation for the UIButton,
     when you use the custom UIButton class.
     */
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
    
}

private var pTouchAreaEdgeInsets: UIEdgeInsets = .zero

extension UIButton {
    
    /// 시스템과 동일한 하이라이트
    func highlight(defaultOpacity: CGFloat = 0.2,
                   duration: Double = 0.3) {
        let opacity: CGFloat = isHighlighted ? defaultOpacity : 1
        if isHighlighted {
            alpha = opacity
        } else {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.alpha = opacity
            }
        }
    }
    
    /// 사진 수정 버튼 Constraint Setup
    func setupPhotoEditButtonConstraints(imageView: UIImageView) {
        snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).offset(2)
            $0.trailing.equalTo(imageView.snp.trailing).offset(2)
        }
    }
    
    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets: UIEdgeInsets = .zero
                value.getValue(&edgeInsets)
                return edgeInsets
            }
            else {
                return .zero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: .zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.touchAreaEdgeInsets == .zero || !self.isEnabled || self.isHidden {
            return super.point(inside: point, with: event)
        }
        
        let relativeFrame = self.bounds
        let hitFrame = relativeFrame.inset(by: self.touchAreaEdgeInsets)
        
        return hitFrame.contains(point)
    }
    
}
