//
//  ModelConfigAppInfo.swift
//
//  Created by Aaron Lee on 2021/07/31.
//

import Foundation

struct ModelConfigAppInfo {
    
    var versionInfo: ModelConfigVersion?
    var noticeInfo: ModelConfigNotice?
    
    /// 버전 정보 변경
    mutating func setupVersionInfo(with versionInfo: ModelConfigVersion?) {
        self.versionInfo = versionInfo
    }
    
    /// 공지 정보 변경
    mutating func setupNoticeInfo(with noticeInfo: ModelConfigNotice?) {
        self.noticeInfo = noticeInfo
    }
    
}
