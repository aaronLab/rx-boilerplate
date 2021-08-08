//
//  NSMutableAttributedString+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

extension NSMutableAttributedString {
    
    /// NSMutableAttributedString의 색상을 변경
    func setColor(color: UIColor? = nil) {
        guard let color = color else { return }
        addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: self.length))
    }

    /// NSMutableAttributedString의 색상을 변경
    func setColor(color: UIColor? = nil, forText stringValue: String?) {
        guard let stringValue = stringValue else { return }
        let range: NSRange = mutableString.range(of: stringValue, options: .caseInsensitive)
        addAttribute(.foregroundColor, value: color ?? .systemGray, range: range)
    }
    
    /// NSMutableAttributedString의 폰트를 변경
    func setFont(_ font: UIFont? = nil) {
        guard let font = font else { return }
        addAttribute(.font, value: font, range: NSRange(location: 0, length: self.length))
    }
    
    /// NSMutableAttributedString의 폰트를 변경
    func setFont(_ font: UIFont? = nil, forText stringValue: String?) {
        guard let font = font,
              let stringValue = stringValue else { return }
        let range: NSRange = mutableString.range(of: stringValue, options: .caseInsensitive)
        addAttribute(.font, value: font, range: range)
    }

}
