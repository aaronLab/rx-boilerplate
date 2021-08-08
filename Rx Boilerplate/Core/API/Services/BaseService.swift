//
//  BaseService.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

/// BaseService
protocol BaseService {
    
    var apiSession: APIService { get }
    
}

extension BaseService {
    
    /// 인증토큰
    var token: String? {
        return URLRequest.token
    }
    
    /// 기본 헤더
    var defaultHeader: [String: String] {
        return URLRequest.defaultHeader
    }
    
    /// 인증 헤더
    var authHeader: [String: String?] {
        return URLRequest.authHeader
    }
    
    /// 기본 AF 헤더
    var defaultAfHeader: HTTPHeaders {
        return URLRequest.defaultAfHeader
    }
    
    /// 인증 AF 헤더
    var authAfHeader: HTTPHeaders {
        return URLRequest.authAfHeader
    }
    
}
