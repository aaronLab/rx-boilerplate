//
//  ModelLocalMediaCollection.swift
//
//  Created by Aaron Lee on 2021/06/07.
//

import UIKit
import Photos

/// 로컬 미디어 컬렉션 모델
struct ModelLocalMediaCollection {
    /// 앨범 ID
    let identifier: String
    /// 앨범 타이틀
    let title: String?
    /// 앨범 미디어 카운트
    let mediaCount: Int
    /// 앨범 썸네일
    let thumbnail: UIImage?
    /// 에셋
    let assets: PHFetchResult<PHAsset>
}
