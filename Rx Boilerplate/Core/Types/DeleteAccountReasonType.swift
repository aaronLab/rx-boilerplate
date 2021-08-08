//
//  DeleteAccountReasonType.swift
//  Rippler
//
//  Created by Aaron Lee on 2021/07/11.
//

import Foundation

/// 탈퇴 사유
enum DeleteAccountReasonType: String, CaseIterable {
    /// 잠시 쉬고 싶어요
    case toGetSomeRest = "ToGetSomeRest"
    /// 알림이 너무 자주 옵니다
    case tooManyNotifications = "TooManyNotifications"
    /// 사용상의 불편함이 있어요
    case uncomfortableToUse = "UncomfortableToUse"
    /// 친구와 싸워서 쓸 일이 없어졌어요
    case argumentsWithFriends = "ArgumentsWithFriends"
    /// 기타
    case others = "Others"
}

extension DeleteAccountReasonType {
    
    var localized: String {
        return rawValue.localized(comment: "번역된 타이틀")
    }
    
}
