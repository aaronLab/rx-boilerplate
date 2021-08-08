//
//  UILabel+Ext.swift
//
//  Created by Aaron Lee on 2021/06/01.
//

import UIKit

extension UILabel {
    
    func addAttributedString(alignment: NSTextAlignment? = nil, spacing: CGFloat? = nil, color: UIColor? = nil, font: UIFont? = nil) {
        
        guard let textString = text else { return }
        
        let attributedString = NSMutableAttributedString(string: textString)
        let range = NSRange(location: 0, length: attributedString.length)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // 정렬
        if let alignment = alignment  {
            paragraphStyle.alignment = alignment
        }
        
        // 줄 간격
        if let spacing = spacing {
            paragraphStyle.lineSpacing = spacing
        }
        
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: range)
        
        // 색상
        if let color = color {
            attributedString.addAttribute(.foregroundColor,
                                          value: color,
                                          range: range)
        }
        
        // 폰트
        if let font = font {
            attributedString.addAttribute(.font,
                                          value: font,
                                          range: range)
        }
        
        attributedText = attributedString
    }
    
    /// 설정 설명 Label Style
    func stylingSettingsDescription() {
        numberOfLines = 0
        font(.context1)
        textAlignment = .left
        textColor = .appColor(.black)
        setContentHuggingPriority(.defaultLow, for: .vertical)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    /// 라인 수
    func lines() -> Int {
        let textSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(sizeThatFits(textSize).height))
        let charSize = lroundf(Float(font.lineHeight))
        let lineCount = rHeight/charSize
        return lineCount
    }
    
}
