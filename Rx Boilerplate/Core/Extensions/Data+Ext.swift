//
//  Data+Ext.swift
//
//  Created by Aaron Lee on 2021/05/28.
//

import Foundation

extension Data {
    
    /// Data -> [String: Any]? 반환 메소드
    func toDict() -> [String: Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        let jsonDict = json as? [String: Any]
        return jsonDict
    }
    
    /// 디코
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        return try? decoder.decode(type, from: self)
    }
    
}
