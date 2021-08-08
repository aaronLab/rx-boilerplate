//
//  ValidationManager.swift
//
//  Created by Aaron Lee on 2021/05/21.
//

import Foundation

/// 유효성 검증 매니저
struct ValidationManager {
    
    /// 휴대폰 번호 검증
    ///
    /// 01012341234 형태
    func isValidMobileNo(candidate: String?) -> Bool {
        let regex = "^010([0-9]{4})([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }
    
    /// 비밀번호 검증
    ///
    /// 영분 숫자 조합 8자 이상 20자 이하
    func isValidPassword(candidate: String?) -> Bool {
        let regex = "^(?=.*[a-zA-Z0-9])(?=.*[a-zA-Z!@#\\$%^&*])(?=.*[0-9!@#\\$%^&*]).{8,20}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }
    
    /// 이메일 검증
    func isValidEmail(candidate: String) -> Bool {
        let regexRFC = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let rfcIsValid = NSPredicate(format: "SELF MATCHES %@", regexRFC).evaluate(with: candidate)
        
        let regexW3C = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let w3cIsValid = NSPredicate(format: "SELF MATCHES %@", regexW3C).evaluate(with: candidate)
        
        return rfcIsValid && w3cIsValid
    }
    
    /// 검색 쿼리 검증
    func isValidSearchQuery(candidate: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^([0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ ])+$",
                                                options: .caseInsensitive)
            if let _ = regex.firstMatch(in: candidate, options: NSRegularExpression.MatchingOptions.reportCompletion,
                                        range: NSMakeRange(0, candidate.count)) {
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
}
