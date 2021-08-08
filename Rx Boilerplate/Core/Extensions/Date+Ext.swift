//
//  Date+Ext.swift
//
//  Created by Aaron Lee on 2021/07/05.
//

import Foundation

extension Date {
    
    /// 년도
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    /// 월
    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    /// 10 미만 월 0 + 월
    var monthWithZero: String {
        return month.zeroForLessThanTen()
    }
    
    /// 일
    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    /// 10 미만 0 + 일
    var dayWithZero: String {
        return day.zeroForLessThanTen()
    }
    
    /// 시
    var hours: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    /// 10 미만 0 + 시
    var hoursWithZero: String {
        return hours.zeroForLessThanTen()
    }
    
    /// 분
    var minutes: Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
    
    /// 10 미만 0 + 분
    var minutesWithZero: String {
        return minutes.zeroForLessThanTen()
    }
    
    /// 초
    var seconds: Int {
        let calendar = Calendar.current
        return calendar.component(.second, from: self)
    }
    
    /// 10 미만 0 + 초
    var secondsWithZero: String {
        return seconds.zeroForLessThanTen()
    }
    
    /// yyyyMMddHHmmss
    func yyyyMMddHHmmss() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: self)
    }
    
    /// 일주일 이내의 날짜
    func isInOneWeek() -> Bool {
        let secondsAgo = -Int(self.timeIntervalSinceNow)
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        return secondsAgo / week < 1
    }
    
    //// yyyy-MM-dd 생일 포매팅
    func v1BirthDayToDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: self)
    }
    
    //// yyyy - MM - dd 생일 포매팅
    func toBirthdayTextFieldDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy - MM - dd"
        
        return formatter.string(from: self)
    }
    
    /// 같은 날
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        return calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    /// 같은 해
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    /// 같은 달
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    /// 같은 주
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    /// 같은 날
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    /// 올해
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    /// 이번 달
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    /// 이번 주
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    
    /// 어제
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    /// 오늘
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    /// 내일
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    
    /// 미래
    var isInTheFuture: Bool { self > Date() }
    /// 과거
    var isInThePast:   Bool { self < Date() }
    
    func getDayString() -> String {
        let days: [String] = ["Sun".localized(comment: "일요일"),
                              "Mon".localized(comment: "월요일"),
                              "Tue".localized(comment: "화요일"),
                              "Wed".localized(comment: "수요일"),
                              "Thu".localized(comment: "목요일"),
                              "Fri".localized(comment: "금요일"),
                              "Sat".localized(comment: "토요일")]
        
        let component = Calendar.current.component(.weekday, from: self)
        
        return days[component - 1]
    }
    
    /// 관심사 시간 타임
    func timeStamp() -> String {
        
        let dayString = self.getDayString()
        
        let formatter = DateFormatter()
        formatter.amSymbol = "AM".localized(comment: "오전")
        formatter.pmSymbol = "PM".localized(comment: "오후")
        formatter.dateFormat = "a hh:mm"
        
        let timeString = formatter.string(from: self)
        
        return "\(dayString) \(timeString)"
    }
    
}
