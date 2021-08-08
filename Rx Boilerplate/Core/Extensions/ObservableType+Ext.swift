//
//  ObservableType+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import RxSwift

extension ObservableType {
    
    /// Void로 매핑
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
}

extension ObservableType where Element == String {
    
    /// Raw 휴대폰 번호 포매팅
    func rawMobileNo() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            var mobileNo = text
            mobileNo = mobileNo.replacingOccurrences(of: " ", with: "")
            mobileNo = mobileNo.replacingOccurrences(of: "-", with: "")
            if mobileNo.count > 11 {
                let index = mobileNo.index(mobileNo.startIndex, offsetBy: 11)
                mobileNo = String(mobileNo[..<index])
            }
            return Observable.just(mobileNo)
        }
    }
    
    /// Display 휴대폰 번호 포매팅
    func displayMobileNo() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            let mobileNo = text.maskedMobileNo()
            return Observable.just(mobileNo)
        }
    }
    
    /// 소문자 변환
    func lowercased() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            return Observable.just(text.lowercased())
        }
    }
    
    /// 대문자 변환
    func uppercased() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            return Observable.just(text.uppercased())
        }
    }
    
    /// 2줄이상 줄바꿈 1줄로 대체
    func removeMoreLineBreakes() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            let lineBreaks = "\n\n"
            let whiteSpaces = "  "
            var newVal = text
            
            if newVal.contains(lineBreaks) {
                newVal = newVal.replacingOccurrences(of: lineBreaks, with: "\n")
            }
            
            if newVal.contains(whiteSpaces) {
                newVal = newVal.replacingOccurrences(of: whiteSpaces, with: " ")
            }
            
            return Observable.just(newVal)
        }
    }
    
    /// 글 수 제한(emoji 포함)
    func maxNumbOfChars(max: Int, emojiCountIsTwo: Bool) -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            var newVal = text
            
            var count = newVal.count
            
            if emojiCountIsTwo {
                count += newVal.emojis.count
            }
            
            if count > max {
                let index = newVal.index(newVal.startIndex, offsetBy: min(max, text.count))
                newVal = String(newVal[..<index])
            }
            
            count = newVal.count + newVal.emojis.count
            
            if count > max {
                newVal.removeLast()
            }
            
            return Observable.just(newVal)
        }
    }
    
    /// 공백 제거
    func removeAllWhiteSpaces() -> Observable<Element> {
        return asObservable().flatMap { text -> Observable<Element> in
            
            let newVal = text.withoutAllWhiteSpaces
            
            return Observable.just(newVal)
        }
    }
    
}

extension ObservableType where Element == CGPoint {
    
    /// 스크롤뷰 -> 페이지 반환, 0부터 시작
    func scrollViewPage(thresholdWidth: CGFloat) -> Observable<Int> {
        return asObservable().flatMap { offset -> Observable<Int> in
            
            if thresholdWidth > 0 {
                let width = thresholdWidth
                let x = offset.x
                
                let page = round(x / width)
                
                return Observable.just(Int(page))
            }
            
            return Observable.just(0)
        }
    }
    
}
