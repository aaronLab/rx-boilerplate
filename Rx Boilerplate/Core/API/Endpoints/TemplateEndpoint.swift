//
//  TemplateEndpoint.swift
//
//  Created by Aaron Lee on 2021/05/27.
//

#if DEBUG

import Foundation

/// <#설명#>
enum TemplateEndpoint: String {
    
    case template
    
}

extension TemplateEndpoint: Endpoint {
    
    var version: BaseURL {
        return .v1
    }
    
    var prefix: String {
        return "/"
    }
    
    var path: String {
        return "\(prefix)\(rawValue)"
    }
    
}

#endif
