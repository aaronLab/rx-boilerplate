//
//  UINavigationController+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

/**
 Navigation Bar를 hidden하면 생기는 제스쳐 문제를 해결
 */

extension UINavigationController: UIGestureRecognizerDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
}

extension UINavigationController {
    
    /// 네비게이션 뷰 컴플리션
    private func doAfterAnimatingTransition(animated: Bool,
                                            completion: (() -> Void)? = nil) {
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil, completion: { _ in
                completion?()
            })
        } else {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    /// 다음 스택으로 이동
    func pushViewController(viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)? = nil) {
        
        pushViewController(viewController,
                           animated: animated)
        doAfterAnimatingTransition(animated: animated,
                                   completion: completion)
    }
    
    /// 현 스택 제거
    func popViewController(animated: Bool,
                           completion: (() -> Void)? = nil) {
        popViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated,
                                   completion: completion)
    }
    
    /// Root로 이동
    func popToRootViewController(animated: Bool,
                                 completion: (() -> Void)? = nil) {
        popToRootViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated,
                                   completion: completion)
    }
    
}
