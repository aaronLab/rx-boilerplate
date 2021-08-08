//
//  APIResult.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

/// APIResult
struct APIResult<T: Decodable> {
    
    var error: APIError?
    var response: T?
    
}
