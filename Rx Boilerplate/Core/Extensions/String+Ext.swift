//
//  String+Ext.swift
//
//  Created by Aaron Lee on 2021/05/21.
//

import Foundation

extension String {
    
    /// 다국어 지원
    func localized(comment: String = "") -> String {
        let locale = UserDefaults.string(for: .locale)
        
        let path = Bundle.main.path(forResource: locale, ofType: "lproj") ?? Bundle.main.path(forResource: "en", ofType: "lproj")!
        let bundle = Bundle(path: path)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: self, comment: comment)
    }
    
    /// 다국어 % 포매팅
    func localized(with args: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), args)
    }
    
    /// 휴대폰 번호 마스킹
    func maskedMobileNo() -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXX - XXXX - XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
    
    /// yyyy-MM-dd HH:mm:ss 시간 변환(TimeZone 적용)
    func v1ServerTimeStamp() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        
        if formatter.date(from: self) != nil {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            return formatter.date(from: self)
        }
        
        return formatter.date(from: self)
    }
    
    //// yyyy-MM-dd 생일 포매팅
    func v1BirthDayToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: self)
    }
    
    /// 글자 뒤 스페이스 삭제
    func trimString() -> Self {
        let newVal = self.trimmingCharacters(in: .whitespaces)
        return newVal
    }
    
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    /// 공백 모두 제거
    var withoutAllWhiteSpaces: Self {
        return self.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
    
}

extension Character {
    
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
