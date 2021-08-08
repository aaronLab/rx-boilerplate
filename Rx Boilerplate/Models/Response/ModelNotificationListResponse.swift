//
//  ModelNotificationListResponse.swift
//  Rippler
//
//  Created by Aaron Lee on 2021/07/08.
//

import Foundation

/// 알림 설정 목록 응답
struct ModelNotificationSettingListResponse: APIResponseV1 {
    
    var code: Int?
    
    var message: String?
    
    var success: Bool?
    
    var data: ModelNotificationListData?

}

struct ModelNotificationListData: Decodable {
    
    var item: [ModelNotificationSetting]?
    
}
