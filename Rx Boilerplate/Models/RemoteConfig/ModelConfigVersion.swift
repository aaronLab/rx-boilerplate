//
//  ModelConfigVersion.swift
//
//  Created by Aaron Lee on 2021/07/31.
//

import UIKit

/// Remote Config Version 모델
struct ModelConfigVersion: Decodable {
    
    var latestVersion: String?
    var minimumVersion: String?
    
    enum CodingKeys: String, CodingKey {
        case latestVersion = "latest_version"
        case minimumVersion = "minimum_version"
    }
    
}

extension ModelConfigVersion {
    
    /// 강제업데이트 유무
    var forceUpdate: Bool {
        guard let minimumVersion = minimumVersion?.split(separator: ".").compactMap({ Int($0) }) else {
            return false
        }
        
        let currentVersion = UIApplication.appVersion.split(separator: ".").compactMap({ Int($0) })
        
        var forceUpdate = false
        
        for (current, minimum) in zip(currentVersion, minimumVersion) {
            if minimum > current {
                forceUpdate = true
                break
            }
        }
        
        return forceUpdate
    }
    
    /// 업데이트 가능
    var updateAvailable: Bool {
        guard let latestVersion = latestVersion?.split(separator: ".").compactMap({ Int($0) }) else {
            return false
        }
        
        let currentVersion = UIApplication.appVersion.split(separator: ".").compactMap({ Int($0) })
        
        var updateAvailable = false
        
        for (current, latest) in zip(currentVersion, latestVersion) {
            if latest > current {
                updateAvailable = true
                break
            }
        }
        
        return updateAvailable
    }
    
}
