//
//  KeychainWrapper+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper {
    
    /// 초기화
    static func reset() {
        KeychainWrapper.standard.remove(forKey: .authToken)
    }
    
}

extension KeychainWrapper.Key {
    
    /// API 토큰
    static let authToken: KeychainWrapper.Key = "authToken"
    
    /// FCM 토큰
    static let fcmToken: KeychainWrapper.Key = "fcmToken"
    
}
