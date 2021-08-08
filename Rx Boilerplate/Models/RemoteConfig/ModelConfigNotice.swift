//
//  ModelConfigNotice.swift
//
//  Created by Aaron Lee on 2021/07/31.
//

import Foundation

struct ModelConfigNotice: Decodable {
    
    var title: String?
    var description: String?
    var close: Bool?
    
}

extension ModelConfigNotice {
    
    /// 앱 사용 불가 강제종료
    var shouldClose: Bool { return close == true }
    
}
