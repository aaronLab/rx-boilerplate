//
//  BaseEndpoint.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

/// BaseURL
enum BaseURL {
    
    case v1
    case v2
    
}

extension BaseURL {
    
    var urlString: String {
        
        #if DEBUG
        
        // 개발 환경
        switch self {
        case .v1:
            return "http://api.rippler.co.kr/api/v1"
        case .v2:
            return "http://api.rippler.co.kr/api/v2"
        }
        
        #else
        
        // 비개발 환경
        switch self {
        case .v1:
            return "http://api.rippler.co.kr/api/v1"
        case .v2:
            return "http://api.rippler.co.kr/api/v2"
        }
        
        #endif
    }
    
}
