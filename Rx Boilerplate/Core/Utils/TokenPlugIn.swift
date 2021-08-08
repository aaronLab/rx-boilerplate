//
//  TokenPlugIn.swift
//
//  Created by Aaron Lee on 2021/06/24.
//

import Foundation
import SwiftKeychainWrapper
import Kingfisher

/// Kingfisher를 통한 이미지 로딩 시 Token Modifier
class TokenPlugIn: ImageDownloadRequestModifier {
    
    let token: String
    
    init() {
        self.token = KeychainWrapper.standard[.authToken] ?? ""
    }
    
    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        request.addValue(token, forHTTPHeaderField: APIHeader.token.rawValue)
        return request
    }
    
}
