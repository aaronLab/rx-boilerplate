//
//  PHAsset+Ext.swift
//
//  Created by Aaron Lee on 2021/06/09.
//

import UIKit
import Photos

extension PHAsset {
    
    /// Get URL
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)) {
        if mediaType == .image {
            let options = PHContentEditingInputRequestOptions()
            
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            
            requestContentEditingInput(with: options,
                                            completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                                                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
                                            })
            
        } else if mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            
            PHImageManager.default().requestAVAsset(forVideo: self, options: options) { asset, audioMix, info in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    
    /// PHAsset을 기반으로 이미지를 반환
    func getImage(size: CGSize, deliveryMode: PHImageRequestOptionsDeliveryMode? = nil, contentMode: PHImageContentMode = .aspectFill, completion: @escaping (UIImage?) -> Void) {
        
        var options: PHImageRequestOptions?
        if let deliveryMode = deliveryMode {
            options = PHImageRequestOptions()
            options?.deliveryMode = deliveryMode
        }
        
        let manager = PHImageManager.default()
        
        manager.requestImage(for: self,
                             targetSize: size,
                             contentMode: contentMode,
                             options: options, resultHandler: { convertedImage, info in
                                
                                let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool ?? false
                                if isDegraded { return }
                                
                                completion(convertedImage)
                             })
    }
    
}
