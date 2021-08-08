//
//  APIResponse.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation

/// API Response V2
protocol APIResponse: Codable {
    
    associatedtype DataType: Codable
    
    var code: Int? { get }
    var data: DataType? { get }
    
}

extension APIResponse {
    
    var success: Bool {
        guard let code = code else { return false }
        return (200...399).contains(code)
    }
    
}
