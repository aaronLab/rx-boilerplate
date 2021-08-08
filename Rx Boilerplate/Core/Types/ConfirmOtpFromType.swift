//
//  ConfirmOtpFromType.swift
//  Rippler
//
//  Created by Aaron Lee on 2021/07/11.
//

import Foundation

/// 결과 뷰 전환을 위한 뷰 구문
enum ConfirmOtpFromType {
    /// 이중 인증
    case twoFactor
    /// 회원가입
    case signUp
    /// 비밀번호 찾기
    case findPassword
    /// 번호 변경
    case changeMobileNo
}
