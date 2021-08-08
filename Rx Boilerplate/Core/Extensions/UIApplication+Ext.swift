//
//  UIApplication+Ext.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import UIKit

extension UIApplication {
    
    /// 앱 버전
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    
    /// 빌드넘버
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    
    /// 전화하기 연동
    static func dial(number: String) {
        
        guard let url = URL(string: "telprompt://\(number)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
    /// Safearea 바텀 여백 사이즈
    static var safeAreaBottom: CGFloat {
        if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
        }
        return 16
    }
    
    /// Safearea 탑 여백 사이즈
    static var safeAreaTop: CGFloat {
        if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
        }
        return 16
    }
    
    /// 최상위 뷰 컨트롤러
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    /// 앱스토어로 이동
    func moveToAppStore(appId: Int) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/\(appId)"),
           UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
}
