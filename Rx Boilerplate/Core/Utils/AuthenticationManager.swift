//
//  AuthenticationManager.swift
//
//  Created by Aaron Lee on 2021/05/28.
//

import Foundation
import SwiftKeychainWrapper

/// 인증을 관리하는 매니저
struct AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() { }
    
    /// 해당 키의 정보를 삭제
    func removeAuthInfo(keys: [KeychainWrapper.Key]) {
        keys.forEach {
            KeychainWrapper.standard.remove(forKey: $0)
        }
    }
    
}
