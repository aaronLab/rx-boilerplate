//
//  Int+Ext.swift
//
//  Created by Aaron Lee on 2021/05/27.
//

import Foundation

extension Int {
    
    /// 초(second)를 mm : ss로 반환
    func sec2mmss() -> String {
        
        let minutes = (self % 3_600) / 60
        let seconds = self % 60
        
        var minutesStr: String {
            minutes < 10 ? "0\(minutes)" : "\(minutes)"
        }
        
        var secondsStr: String {
            seconds < 10 ? "0\(seconds)" : "\(seconds)"
        }
        
        return "\(minutesStr):\(secondsStr)"
    }
    
    /// 10 미만 0 앞자리 플레이스홀더
    func zeroForLessThanTen() -> String {
        self < 10 ? "0\(self)" : "\(self)"
    }
    
    /// 짝수
    var isEvenNumber: Bool {
        return self % 2 == 0
    }
    
    /// 음수
    var isOddNumber: Bool {
        return self % 2 != 0
    }
    
    /// Unix Timestamp -> 날짜
    func unix2Date() -> Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(self / 1_000))
        return date
    }
    
    /// 시 분 초 반환
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3_600, (seconds % 3_600) / 60, (seconds % 3_600) % 60)
    }
    
    /// 분 초 반환
    static func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3_600) / 60, (seconds % 3_600) % 60)
    }
    
    /// 10미만 숫자 0과 함께 반환
    func strWithZeroIfLoswerThanTen() -> String {
        return self < 10 ? "0\(self)" : "\(self)"
    }
    
}
