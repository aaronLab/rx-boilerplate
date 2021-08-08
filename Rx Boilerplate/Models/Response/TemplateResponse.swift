//
//  TemplateResponse.swift
//
//  Created by Aaron Lee on 2021/05/26.
//

#if DEBUG

import Foundation

/// <#설명#>
struct TemplateResponse: APIResponse {
    
    var code: Int?
    
    var data: TemplateResponseData?

}

struct TemplateResponseData: Codable {
    
}

#endif
