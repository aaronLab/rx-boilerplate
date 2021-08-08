//
//  APIError.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

/// API 에러
enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}

extension APIError: Equatable {
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.decodingError, .decodingError):
            return true
        case (.httpError(let lStatusCode), .httpError(let rStatusCode)):
            return lStatusCode == rStatusCode
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
    
}
