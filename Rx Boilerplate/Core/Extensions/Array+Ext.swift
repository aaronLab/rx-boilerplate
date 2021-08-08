//
//  Array+Ext.swift
//
//  Created by Aaron Lee on 2021/07/13.
//

import Foundation

extension Array where Element: Comparable {
    
    /// Array 내용이 똑같은지 반환
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
    
}
