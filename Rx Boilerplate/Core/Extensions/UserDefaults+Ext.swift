//
//  UserDefaults+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

/// UserDefaults 키 종류
enum UserDefaultsKey: String {
    /// 자동 로그인, Bool
    case isAutoLogIn
    /// 언어 설정, String
    case locale
    /// 연락처 자동 동기화, Bool
    case contactAutoSync
    /// 새 연락처 자동 블라인드 풀 추가, Bool
    case contactAutoBlind
    /// 나를 공개대상으로 한 게시물을 받았을 때 알림, Bool
    case mailToMeNotification
    /// 이중인증 등록 여부, Bool
    case twoFactorPasswordIsOn
    /// 관심사 피드 튜토리얼 완료 여부, Bool
    case interestFeedTutorialDone
}

extension UserDefaults {
    
    /// 초기화
    static func reset() {
        UserDefaults.save(for: .isAutoLogIn, value: true)
        UserDefaults.save(for: .contactAutoSync, value: true)
        UserDefaults.save(for: .contactAutoBlind, value: false)
        UserDefaults.delete(for: .mailToMeNotification)
        UserDefaults.delete(for: .twoFactorPasswordIsOn)
        UserDefaults.delete(for: .interestFeedTutorialDone)
    }
    
    /**
     Key를 기준으로 UserDefaults를 저장
     - Parameters:
     - key: 저장하려는 종류
     - value: 저장할 값
     ```
     UserDefaults.standard.save(value, forKey: .authToken)
     ```
     */
    static func save(for key: UserDefaultsKey, value: Any) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Key를 기준으로 UserDefaults value를 반환
     - Parameter key: 불러오려는 종류
     - Returns: Any
     ```
     UserDefaults.any(forKey: .authToken)
     ```
     */
    static func any(for key: UserDefaultsKey) -> Any {
        return UserDefaults.standard.object(forKey: key.rawValue) as Any
    }
    
    /**
     Key를 기준으로 UserDefaults value(Bool?)를 반환
     - Parameter key: 불러오려는 종류
     - Returns: Bool?
     ```
     UserDefaults.bool(forKey: .doneIntro)
     ```
     */
    static func bool(for key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    /**
     Key를 기준으로 UserDefaults value(String?)를 반환
     - Parameter key: 불러오려는 종류
     - Returns: String?
     ```
     UserDefaults.string(forKey: .authToken)
     ```
     */
    static func string(for key: UserDefaultsKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    /**
     Key를 기준으로 UserDefaults value를 삭제
     - Parameter key: 삭제하려는 종류
     ```
     UserDefaults.delete(forKey: .authToken)
     ```
     */
    static func delete(for key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    /**
     Key를 기준으로 UserDefaults에 해당 키의 value가 존재하는지 반환
     - Parameter key: 확인하려는 종류
     - Returns: Bool
     ```
     UserDefaults.isExisting(forKey: .authToken)
     ```
     */
    static func isExisting(for key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: UserDefaultsKey
    /// - Throws: UserDefaults Error
    static func save<T: Codable>(object: T, forKey: UserDefaultsKey) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        UserDefaults.standard.set(jsonData, forKey: forKey.rawValue)
    }
    
    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: UserDefaultsKey
    /// - Throws: UserDefaults Error
    static func get<T: Codable>(objectType: T.Type, forKey: UserDefaultsKey) throws -> T? {
        
        guard let result = UserDefaults.standard.value(forKey: forKey.rawValue) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
}
