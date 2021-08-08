//
//  CameraManager.swift
//
//  Created by Aaron Lee on 2021/06/09.
//

import Foundation
import AVFoundation

/// 카메라 메니저
struct CameraManager {
    
    /// 권한 확인
    func checkPermission(mediaType: AVMediaType, completion: @escaping (Bool) -> Void) {
        
        if AVCaptureDevice.authorizationStatus(for: mediaType) == .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                completion(granted)
            }
        }
    }
    
}
