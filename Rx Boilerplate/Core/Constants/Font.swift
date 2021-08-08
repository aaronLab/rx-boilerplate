//
//  Font.swift
//
//  Created by Aaron Lee on 2021/06/22.
//

import UIKit

/// 폰트 타입
fileprivate enum FontType: String {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
}

enum Font: CaseIterable {
    /// 22 regular
    case title1
    
    /// 22 medium
    case title2
    
    /// 22 bold
    case title3
    
    /// 24 regular
    case title4
    
    /// 24 medium
    case title5
    
    /// 24 bold
    case title6
    
    /// 타이틀 전체
    static var titles: [Font] {
        return [.title1,
                .title2,
                .title3,
                .title4,
                .title5,
                .title6]
    }
    
    /// 18 regular
    case subtitle1
    
    /// 18 medium
    case subtitle2
    
    /// 18 bold
    case subtitle3
    
    /// 20 regular
    case subtitle4
    
    /// 20 medium
    case subtitle5
    
    /// 20 bold
    case subtitle6
    
    /// Subtitle 전체
    static var subtitles: [Font] {
        return [.subtitle1,
                .subtitle2,
                .subtitle3,
                .subtitle4,
                .subtitle5,
                .subtitle6]
    }
    
    /// 16 regular
    case body1
    
    /// 16 medium
    case body2
    
    /// 16 bold
    case body3
    
    /// 14 regular
    case body4
    
    /// 14 medium
    case body5
    
    /// 14 bold
    case body6
    
    /// Body 전체
    static var bodies: [Font] {
        return [.body1,
                .body2,
                .body3,
                .body4,
                .body5,
                .body6]
    }
    
    /// 12 regular
    case context1
    
    /// 12 medium
    case context2
    
    /// 12 bold
    case context3
    
    /// 10 regular
    case context4
    
    /// 10 medium
    case context5
    
    /// 10 bold
    case context6
    
    /// Context 전체
    static var contexts: [Font] {
        return [.context1,
                .context2,
                .context3,
                .context4,
                .context5,
                .context6]
    }
    
    /// 34 regular
    case headline1
    /// 34 medium
    case headline2
    /// 34 bold
    case headline3
    
    /// Headline 전체
    static var headlines: [Font] {
        return [
            .headline1,
            .headline2,
            .headline3]
    }
    
}

extension Font {
    
    /// 언어 코드
    ///
    /// https://developer.apple.com/documentation/foundation/nslocale
    ///
    /// https://gist.github.com/jacobbubu/1836273
    private func languageCode() -> Constants.Locale? {
        let localeStr = String(UIDevice.currentLocale.prefix(2))
        return Constants.Locale(rawValue: localeStr)
    }
    
    /// 폰트 파일 명
    private func localizedFontName() -> String {
        let defaultFont = "SpoqaHanSansNeo-"
        
        let code = languageCode()
        
        switch code {
        case .english, .korean: return defaultFont
        default: return defaultFont
        }
        
    }
    
    var font: UIFont? {
        
        let fontType: FontType
        var fontSize: CGFloat
        
        switch self {
        case .title1:
            fontType = .regular
            fontSize = 22
        case .title2:
            fontType = .medium
            fontSize = 22
        case .title3:
            fontType = .bold
            fontSize = 22
        case .title4:
            fontType = .regular
            fontSize = 24
        case .title5:
            fontType = .medium
            fontSize = 24
        case .title6:
            fontType = .bold
            fontSize = 24
        case .subtitle1:
            fontType = .regular
            fontSize = 18
        case .subtitle2:
            fontType = .medium
            fontSize = 18
        case .subtitle3:
            fontType = .bold
            fontSize = 18
        case .subtitle4:
            fontType = .regular
            fontSize = 20
        case .subtitle5:
            fontType = .medium
            fontSize = 20
        case .subtitle6:
            fontType = .bold
            fontSize = 20
        case .body1:
            fontType = .regular
            fontSize = 16
        case .body2:
            fontType = .medium
            fontSize = 16
        case .body3:
            fontType = .bold
            fontSize = 16
        case .body4:
            fontType = .regular
            fontSize = 14
        case .body5:
            fontType = .medium
            fontSize = 14
        case .body6:
            fontType = .bold
            fontSize = 14
        case .context1:
            fontType = .regular
            fontSize = 12
        case .context2:
            fontType = .medium
            fontSize = 12
        case .context3:
            fontType = .bold
            fontSize = 12
        case .context4:
            fontType = .regular
            fontSize = 10
        case .context5:
            fontType = .medium
            fontSize = 10
        case .context6:
            fontType = .bold
            fontSize = 10
        case .headline1:
            fontType = .regular
            fontSize = 34
        case .headline2:
            fontType = .medium
            fontSize = 34
        case .headline3:
            fontType = .bold
            fontSize = 34
        }
        
        if !Font.contexts.contains(self) && UIDevice.isSmallDevice {
            fontSize -= 1
        }
        
        return UIFont(name: "\(localizedFontName())\(fontType.rawValue)",
                      size: fontSize)
    }
    
}
