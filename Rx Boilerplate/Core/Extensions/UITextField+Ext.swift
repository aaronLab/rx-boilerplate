//
//  UITextField+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//


import UIKit
import RxSwift
import RxCocoa

extension UITextField {
    
    /// Placeholder 추가 및 색상 설정
    func setPlaceholderColor(placeholder: String = "",
                             color: UIColor? = .appColor(.black),
                             font: UIFont? = .font(.body1),
                             alignment: NSTextAlignment? = nil) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        } else {
            paragraphStyle.alignment = .left
        }
        
        let placeholderAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: color ?? .systemGray,
                                                                   .font: font ?? .systemFont(ofSize: 16),
                                                                   .paragraphStyle: paragraphStyle]
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: placeholderAttribute)
        
    }
    
    /// 왼쪽 공간 추가
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    /// 우측 공간 추가
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    /// Factory method that enables subclasses to implement their own `delegate`.
    ///
    /// - returns: Instance of delegate proxy that wraps `delegate`.
    public func createRxDelegateProxy() -> RxTextFieldDelegateProxy {
        return RxTextFieldDelegateProxy(textField: self)
    }
    
}


extension Reactive where Base: UITextField {
    
    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for `delegate` message.
    public var shouldReturn: ControlEvent<Void> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldReturn))
            .map { _ in }
        
        return ControlEvent(events: source)
    }
    
    public var shouldClear: ControlEvent<Void> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldClear))
            .map { _ in }
        
        return ControlEvent(events: source)
    }
    
}
