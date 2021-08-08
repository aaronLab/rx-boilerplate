//
//  AppDelegate.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import AVFoundation
import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import SwiftKeychainWrapper
import Kingfisher
import Toast_Swift

let Application = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var shouldSupportAllOrientation = false
    var appSwitcher: UIWindow?
    
    /// Token PlugIn
    let tokenPlugIn = TokenPlugIn()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase
        FirebaseApp.configure()
        
        // FCM
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        
        // IQKeyboard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // 텍스트필드 및 뷰 틴트색상
        UITextField.appearance().tintColor = .appColor(.black)
        UITextView.appearance().tintColor = .appColor(.black)
        
        // 로케일
        configureLocale()
        DebugManager.shared.print(title: "Current Locale",
                                  description: UserDefaults.string(for: .locale),
                                  type: .normal)
        
        // 자동 동기화
        configureContactSync()
        
        // 이미지 로더 토큰 전달용 Modifier 적용 초기화
        KingfisherManager.shared.defaultOptions = [.requestModifier(tokenPlugIn)]
        
        // 토스트 스타일
        var toastStyle = ToastStyle()
        toastStyle.messageFont = .font(.context1) ?? .systemFont(ofSize: 12, weight: .semibold)
        toastStyle.messageColor = .appColor(.white) ?? .white
        toastStyle.backgroundColor = .appColor(.black)?.withAlphaComponent(0.8) ?? .black.withAlphaComponent(0.8)
        toastStyle.messageAlignment = .center
        toastStyle.titleAlignment = .center
        
        ToastManager.shared.style = toastStyle
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
        
        // 미디어
        try? AVAudioSession.sharedInstance().setCategory(.playback,
                                                    mode: .default,
                                                    options: .mixWithOthers)
        
        // 첫 뷰 초기화
        let vc = TemplateViewController()
        let navC = UINavigationController(rootViewController: vc)
        navC.isNavigationBarHidden = true
        
        window = UIWindow()
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: supportedInterfaceOrientationsFor
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if shouldSupportAllOrientation {
            return UIInterfaceOrientationMask.all
        }
        
        return UIInterfaceOrientationMask.portrait
    }
    
    // MARK: didRegisterForRemoteNotificationsWithDeviceToken
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DebugManager.shared.print(title: "didRegisterForRemoteNotificationsWithDeviceToken", type: .normal)
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        showAppSwitcher()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        hideAppSwitcher()
    }
    
    // MARK: Helpers
    
    /// 지역 정보 저장
    private func configureLocale() {
        
        if !UserDefaults.isExisting(for: .locale) {
            let localeId = Locale.preferredLanguages[0].prefix(2)
            UserDefaults.save(for: .locale, value: localeId)
        }
        
    }
    
    /// 연락처 동기화 설정
    private func configureContactSync() {
        
        DebugManager.shared.print(title: "Contact Auto Sync",
                                  description: UserDefaults.bool(for: .contactAutoSync),
                                  type: .normal)
        
        DebugManager.shared.print(title: "Contact Auto Blind",
                                  description: UserDefaults.bool(for: .contactAutoBlind),
                                  type: .normal)
        
        /// 연락처 자동 동기화
        if !UserDefaults.isExisting(for: .contactAutoSync) {
            UserDefaults.save(for: .contactAutoSync, value: true)
        }
        
        /// 새 연락처 자동 블라인드풀
        if !UserDefaults.isExisting(for: .contactAutoBlind) {
            UserDefaults.save(for: .contactAutoBlind, value: false)
        }
        
    }
    
    /// AppSwitcher 보여주기
    private func showAppSwitcher() {
        appSwitcher = UIWindow(frame: UIScreen.main.bounds)
        appSwitcher?.rootViewController = UIViewController()
        appSwitcher?.windowLevel = .alert + 1
        appSwitcher?.makeKeyAndVisible()
    }
    
    /// AppSwitcher 감추기
    private func hideAppSwitcher() {
        appSwitcher?.isHidden = true
        appSwitcher = nil
    }
    
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        DebugManager.shared.print(title: "Push Notification Received",
                                  description: userInfo,
                                  type: .success)
        
        completionHandler([[.alert, .sound]])

    }
    
}

// MARK: - MessagingDelegate

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        DebugManager.shared.print(title: "FCM Token Received",
                                  description: fcmToken,
                                  type: .success)
        
        KeychainWrapper.standard[.fcmToken] = fcmToken
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        DebugManager.shared.print(title: "FCM Token Registered", type: .normal)
        
    }
    
}
