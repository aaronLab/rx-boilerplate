//
//  NotificationCenter+Ext.swift
//
//  Created by Aaron Lee on 2021/05/27.
//

import Foundation
import RxSwift

extension NotificationCenter {
    
    /// 키보드가 사라질 때 키보드 높이를 함께 반환하는 Observable
    func keyboardWillHideObservable() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
    }
    
    /// 키보드가 나타날 때 키보드 높이를 함께 반환하는 Observable
    func keyboardWillShowObservable() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
    }
    
    /// 키보드 변경 시 높이 반환 Observable
    func keyboardWillChangeFrame() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillChangeFrameNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
    }
    
    /// 키보드 변경 후 높이 반환 Observable
    func keyboardDidChangeFrameNotification() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardDidChangeFrameNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
    }
    
    /// 앱 비활성화
    func applicationWillResignActive() -> Observable<Notification> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willResignActiveNotification)
    }
    
    /// 앱 활성화
    func applicationDidBecomeActive() -> Observable<Notification> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
    }
    
}
