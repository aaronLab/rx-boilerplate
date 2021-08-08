//
//  AlbumManager.swift
//
//  Created by Aaron Lee on 2021/06/07.
//

import UIKit
import Photos
import RxSwift
import RxCocoa

/// 앨범 매니저
struct AlbumManager {
    
    private let manager = PHImageManager.default()
    
    /// 권한 확인
    func checkPermission(completion: @escaping (Bool) -> Void) {
        let status = getCurrentPermissionStatus()
        
        if status == .notDetermined {
            // 권한 정의되지 않음
            PHPhotoLibrary.requestAuthorization { status in
                
                switch status {
                
                case .authorized:
                    // 승인
                    completion(true)
                default:
                    // 거절
                    completion(false)
                    
                }
                
            }
        } else {
            // 권한 정의됨
            switch status {
            
            case .authorized:
                completion(true)
            default:
                completion(false)
                
            }
        }
        
    }
    
    /// 현재 권한 반환
    private func getCurrentPermissionStatus() -> PHAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        return status
    }
    
    /// 앨범 이름 및 카운팅 목록
    func getCollections(mediaType: PHAssetMediaType, completion: @escaping ([ModelLocalMediaCollection]) -> Void) {
        // 모델 목록
        var modelCollections = [ModelLocalMediaCollection]()
        
        if mediaType == .video {
            
            // 비디오
            let videoCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumVideos, options: nil)
            modelCollections += getCollectionModel(mediaType: mediaType, from: videoCollection)
            // 슬로모션
            let slomoVideoCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSlomoVideos, options: nil)
            modelCollections += getCollectionModel(mediaType: mediaType, from: slomoVideoCollection)
            
            completion(modelCollections)
            return
        }
        
        // 최근 사진
        let recentPhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: recentPhotos)
        // 즐겨찾는 항목 앨범
        let favouritePhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: favouritePhotos)
        // 최근 추가된 항목
        let recentAddedPhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: recentAddedPhotos)
        // 인물사진
        let portraitPhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumDepthEffect, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: portraitPhotos)
        // 스크린샷
        let screenshotPhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumScreenshots, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: screenshotPhotos)
        // 셀카
        let selfiePhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSelfPortraits, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: selfiePhotos)
        // 사용자 앨범
        let customAlbumPhotos = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        modelCollections += getCollectionModel(mediaType: mediaType, from: customAlbumPhotos)
        
        completion(modelCollections)
    }
    
    /// 컬렉션 모델 얻기
    private func getCollectionModel(mediaType: PHAssetMediaType, from collections: PHFetchResult<PHAssetCollection>) -> [ModelLocalMediaCollection] {
        var fetchedCollections = [ModelLocalMediaCollection]()
        
        collections.enumerateObjects { collection, index, object in
            // 미디어
            let fetchedCollection = getAssetResult(mediaType: mediaType, from: collection)
            // 컬렉션 ID
            let collectionIdentifier = collection.localIdentifier
            // 컬렉션 타이틀
            let collectionTitle = collection.localizedTitle
            // 썸네일
            let thumbnail = getThumbnail(from: fetchedCollection.firstObject)
            // 미디어 카운트
            let mediaCount = fetchedCollection.count
            // 모델
            let model = ModelLocalMediaCollection(identifier: collectionIdentifier,
                                                  title: collectionTitle,
                                                  mediaCount: mediaCount,
                                                  thumbnail: thumbnail,
                                                  assets: fetchedCollection)
            
            fetchedCollections.append(model)
        }
        
        return fetchedCollections
    }
    
    /// 컬렉션 기준으로 에셋 반환
    func getAssetResult(mediaType: PHAssetMediaType, from collection: PHAssetCollection) -> PHFetchResult<PHAsset> {
        // 정렬 및 미디어 타입
        let collectionOptions = PHFetchOptions()
        collectionOptions.predicate = NSPredicate(format: "mediaType == %d", mediaType.rawValue)
        collectionOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return PHAsset.fetchAssets(in: collection, options: collectionOptions)
    }
    
    /// 앨범에서 썸네일 가져오기
    private func getThumbnail(from collectionAsset: PHAsset?, size: CGSize = CGSize(width: 256, height: 256)) -> UIImage?  {
        guard let asset = collectionAsset else { return nil}
        
        var thumbnail: UIImage?
        
        manager.requestImage(for: asset,
                             targetSize: size,
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
            thumbnail = image
        }
        
        return thumbnail
    }
    
    /// PHFetchResult를 기반으로 PHAsset Array 반환
    func getAssets(from result: PHFetchResult<PHAsset>?) -> [PHAsset?] {
        var assets = [PHAsset]()
        
        result?.enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        
        return assets
    }
    
    /// PHAsset을 기반으로 이미지를 반환
    func getImage(from asset: PHAsset?, size: CGSize, deliveryMode: PHImageRequestOptionsDeliveryMode? = nil, contentMode: PHImageContentMode = .aspectFill, completion: @escaping (UIImage?) -> Void) {
        guard let asset = asset else { return completion(nil) }
        
        var options: PHImageRequestOptions?
        if let deliveryMode = deliveryMode {
            options = PHImageRequestOptions()
            options?.deliveryMode = deliveryMode
        }
        
        manager.requestImage(for: asset,
                             targetSize: size,
                             contentMode: .aspectFill,
                             options: options, resultHandler: { convertedImage, _ in
                                completion(convertedImage)
                             })
    }
    
    /// 촬영 직후 가장 최근 Asset
    func getLatestMedia(mediaType: MediaType, completion: @escaping (PHAsset?) -> Void, size: CGSize = CGSize(width: 256, height: 256)) {
        let fetchOptions: PHFetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let type: PHAssetMediaType = mediaType == .video ? .video : .image
        let fetchResult = PHAsset.fetchAssets(with: type, options: fetchOptions)
        
        let lastAsset: PHAsset? = fetchResult.lastObject
        completion(lastAsset)
    }
    
}
