//
//  CachingManager.swift
//
//  Created by Aaron Lee on 2021/07/14.
//

import Foundation
import SwiftKeychainWrapper
import Kingfisher

/// 캐싱 파일 이름
enum CachingFileName: String, CaseIterable {
    /// 우편함 프로필
    case name = "name.json"
}

/// 캐싱 매니저
struct CachingManager {
    
    static var shared: CachingManager? = CachingManager()
    
    private init() { }
    
    enum Directory {
        // 문서, 사용자 허용 데이터 등(아이클라우드 백업됨)
        case documents
        
        // 캐싱
        case caches
    }
    
    /// Document Directory URL 반환
    fileprivate func getURL(for directory: Directory) -> URL? {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        return FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first
    }
    
    
    /// 데이터 저장
    func save<T: Encodable>(_ object: T, to directory: Directory, as fileName: CachingFileName) {
        guard let url = getURL(for: directory)?.appendingPathComponent(fileName.rawValue, isDirectory: false) else { return }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            return
        }
        
    }
    
    /// 데이터 불러오기
    func get<T: Decodable>(_ fileName: CachingFileName, from directory: Directory, as type: T.Type) -> T? {
        guard let url = getURL(for: directory)?.appendingPathComponent(fileName.rawValue, isDirectory: false) else { return nil }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    /// Directory 삭제
    func clearDirectory(_ directory: Directory) {
        guard let url = getURL(for: directory) else { return }
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            return
        }
    }
    
    /// 특정 파일 삭제
    func removeFile(_ fileName: CachingFileName, from directory: Directory) {
        guard let url = getURL(for: directory)?.appendingPathComponent(fileName.rawValue, isDirectory: false) else { return }
        DispatchQueue.global(qos: .background).async {
            if FileManager.default.fileExists(atPath: url.path) {
                do {
                    try FileManager.default.removeItem(at: url)
                } catch {
                    return
                }
            }
        }
    }
    
    /// 파일 존재 여부 반환
    func fileExists(_ fileName: CachingFileName, in directory: Directory) -> Bool {
        guard let url = getURL(for: directory)?.appendingPathComponent(fileName.rawValue, isDirectory: false) else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    /// 전체 삭제 및 초기화
    func reset() {
        CachingFileName.allCases.forEach {
            removeFile($0, from: .caches)
        }
        
        UserDefaults.reset()
        KeychainWrapper.reset()
        
        let imageCache = ImageCache.default
        imageCache.clearMemoryCache()
        imageCache.clearDiskCache()
        imageCache.cleanExpiredMemoryCache()
        imageCache.cleanExpiredDiskCache()
        
        CachingManager.shared = CachingManager()
    }
    
}

// MARK: - <#Name#>

extension CachingManager {
    
    /// Name
    func getName() -> String? {
        return get(.name, from: .caches, as: String.self)
    }
    
}
