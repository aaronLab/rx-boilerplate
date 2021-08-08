//
//  Encodable+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

extension Encodable {
    
    /// Encodable을  Data? 로 변환
    func toJson() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
