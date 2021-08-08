//
//  DebugManager.swift
//
//  Created by Aaron Lee on 2021/05/24.
//

import Foundation

/// 디버그 매니저
struct DebugManager {
    
    static let shared = DebugManager()
    
    private init() { }
    
    enum DebugType {
        /// 일반
        case normal
        /// 성공
        case success
        /// 오류
        case error
    }
    
    /// 디버깅
    func print(title: String? = nil, description: Any? = nil, type: DebugType = .normal) {
        #if DEBUG
        
        var symbol: String {
            switch type {
            case .normal:
                return "[💬💬💬]"
            case .success:
                return "[✅✅✅]"
            case .error:
                return "[⚠️⚠️⚠️]"
            }
        }
        
        Swift.print("--------------------------------------------------")
        Swift.print("\(symbol) \(title ?? "")")
        
        guard let description = description else { return }
        
        if let decodableData = description as? Decodable {
            dump(decodableData)
        } else {
            Swift.print(description)
        }
        
        #endif
    }
    
}
