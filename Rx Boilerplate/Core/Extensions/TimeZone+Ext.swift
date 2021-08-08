//
//  TimeZone+Ext.swift
//
//  Created by Aaron Lee on 2021/07/21.
//

import Foundation

extension TimeZone {
    
    /// 현재 타임존 차이
    static func currentGMT() -> Int {
        let seconds = TimeZone.current.secondsFromGMT()
        let hours = seconds / 3_600
        return hours
    }
    
}
