//
//  MultipartData.swift
//
//  Created by Aaron Lee on 2021/05/27.
//

import Foundation

extension MultipartData {
    
    /// 파라미터 키
    enum Key: String {
        /// 이미지
        case file = "file"
    }
    
}

extension MultipartData {
    
    /// MimeType
    enum MimeType: String {
        /// JPEG
        case jpeg = "image/jpeg"
        
        /// Extension
        var `extension`: String {
            switch self {
            case .jpeg: return ".jpeg"
            }
        }
    }
    
}

/// 업로드를 위한 multipart 데이터
struct MultipartData {
    var data: Data
    var key: Key
    var fileName: String?
    var mimeType: MimeType?
}

extension MultipartData {
    
    init(data: Data, key: Key, mimeType: MimeType?) {
        self.data = data
        self.key = key
        self.mimeType = mimeType
        
        let uuid = UUID().uuidString
        let fileName = uuid + (mimeType?.extension ?? "")
        self.fileName = fileName
    }
    
}
