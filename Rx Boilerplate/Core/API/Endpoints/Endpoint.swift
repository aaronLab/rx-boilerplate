//
//  Endpoint.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation

/// Endpoint
protocol Endpoint {
    
    /// 버전
    var version: BaseURL { get }
    
    /// 해당 엔드포인트의 최상위 고정 path
    var prefix: String { get }
    
    /// 해당 엔드포인트의 하위 path
    var path: String { get }
    
    /// 해당 엔드포인트의 URL String
    var urlString: String { get }
    
    /// 해당 엔드포인트의 URL
    var url: URL { get }
    
}

extension Endpoint {
    
    /// URL String
    var urlString: String {
        return "\(version.urlString)\(path)"
    }
    
    /// URL
    var url: URL {
        guard let url = URL(string: urlString) else {
            fatalError(">> AuthEndpoint url: Invalid URL")
        }
        
        return url
    }
    
}
