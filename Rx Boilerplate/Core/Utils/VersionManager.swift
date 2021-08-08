//
//  VersionManager.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation

/// 버전 매니저
struct VersionManager {
    
    enum VersioningError: Error {
        /// 응답 오류
        case invalidResponse
        /// 번들 ID 오류
        case invalidBundleInfo
    }
    
    static let shared = VersionManager()
    
    /// 환경 설정용 버전
    var versionAndBuild: String? {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String,
              let build = dictionary["CFBundleVersion"] as? String else { return nil }
        let versionAndBuild: String = "\(version)(\(build))"
        return versionAndBuild
    }
    
    private init() { }
    
    /// 업데이트 가능 여부 체크
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws {
        
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String,
              let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersioningError.invalidBundleInfo
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            do {
                
                if let error = error { throw error }
                
                guard let data = data else { throw VersioningError.invalidResponse }
                
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any],
                      let version = result["version"] as? String else {
                    
                    throw VersioningError.invalidResponse
                    
                }
                
                guard let versionFloat = Float(version),
                      let currentVersionFloat = Float(currentVersion) else {
                    
                    throw VersioningError.invalidBundleInfo
                    
                }
                
                completion(versionFloat > currentVersionFloat, nil)
                
            } catch {
                
                completion(false, error)
                
            }
            
        }
        
        task.resume()
        
    }
    
}
