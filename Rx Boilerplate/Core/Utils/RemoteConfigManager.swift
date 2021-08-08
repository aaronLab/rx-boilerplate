//
//  RemoteConfigManager.swift
//
//  Created by Aaron Lee on 2021/07/31.
//

import Foundation
import Firebase

/// Remote Config Manager
class RemoteConfigManager {
    
    // MARK: - Public Properties
    
    static let shared = RemoteConfigManager()
    
    /// 앱 정보
    var appInfo: ModelConfigAppInfo?
    
    // MARK: - Private Properties
    
    /// Remote Config SingleTon
    private var remoteConfig: RemoteConfig!
    
    // MARK: - Init
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        
        // Settings
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        
        remoteConfig.configSettings = remoteConfigSettings
    }
    
    // MARK: - Helpers
    
    /// Fetch
    func fetchAppInfo(completion: @escaping (_ appInfo: ModelConfigAppInfo?) -> Void) {
        
        if appInfo != nil {
            completion(appInfo)
            return
        }
        
        let expirationDuration: TimeInterval = 0
        
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { [weak self] status, error in
            
            self?.remoteConfig.activate(completion: nil)
            
            var appInfo: ModelConfigAppInfo = ModelConfigAppInfo(versionInfo: nil,
                                                                 noticeInfo: nil)
            
            // 버전 정보
            if let versionInfoData = self?.remoteConfig[RemoteConfigType.version.rawValue].dataValue {
                let versionInfo = versionInfoData.decode(ModelConfigVersion.self)
                appInfo.setupVersionInfo(with: versionInfo)
            }
            
            // 공지 정보
            if let noticeInfoData = self?.remoteConfig[RemoteConfigType.notice.rawValue].dataValue {
                let noticeInfo = noticeInfoData.decode(ModelConfigNotice.self)
                appInfo.setupNoticeInfo(with: noticeInfo)
            }
            
            self?.appInfo = appInfo
            
            completion(appInfo)
        }
    }
    
}
