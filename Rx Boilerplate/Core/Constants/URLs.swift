//
//  URLs.swift
//
//  Created by Aaron Lee on 2021/07/11.
//

import Foundation

extension Constants {
    
    enum URLs: String {
        
        case url = "https://url.url"
        
    }
    
}

extension Constants.URLs {
    
    var url: URL? {
        return URL(string: rawValue)
    }
    
}
