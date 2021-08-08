//
//  ModelFriendSyncBody.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation

/// 연락처 서버 전송 바디
struct ModelFriendSyncBody: Encodable {
    
    let contacts: [ModelFriendSyncContent?]?
    
}

struct ModelFriendSyncContent: Encodable {
    
    /// 번호
    let mobileNo: String?
    
    /// 이름
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case mobileNo = "num"
        case name = "name"
    }
    
}
