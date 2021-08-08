//
//  VideoThumbnailImageProvider.swift
//
//  Created by Aaron Lee on 2021/07/15.
//

import AVFoundation
import Foundation
import Kingfisher

/// 비디오 썸네일 Provider
struct VideoThumbnailImageProvider: ImageDataProvider {
    
    /// 에러
    enum ProviderError: Error {
        case convertingFailed(CGImage)
    }
    
    /// 비디오 URL
    let url: URL
    /// 썸네일 Size
    let size: CGSize
    
    /// 캐싱 키
    var cacheKey: String { return "\(url.absoluteString)_\(size)" }
    
    /// 데이터
    func data(handler: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            let asset = AVAsset(url: self.url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            
            assetImgGenerate.appliesPreferredTrackTransform = true
            assetImgGenerate.maximumSize = self.size
            
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                
                if let data = UIImage(cgImage: img).jpegData(compressionQuality: 0.8) {
                    handler(.success(data))
                } else {
                    handler(.failure(ProviderError.convertingFailed(img)))
                }
                
            } catch {
                
                handler(.failure(error))
            }
            
        }
    }
    
}
