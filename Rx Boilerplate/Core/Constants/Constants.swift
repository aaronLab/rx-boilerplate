//
//  Constants.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit

/// Constants
struct Constants {
    
    // Animation Duration
    /// 애니메이션 기본 Duration
    static let animationDefaultDuration: Double = 0.3
    /// Transition 기본 Duration
    static let transitionDefaultDuration: Double = 0.15
    /// 스크롤 Refresh Delay 기본 Duration
    static let scrollRefreshDelayDuration: Double = 2.0
    /// 토스트 키본 시간
    static let toastDisplayTime: TimeInterval = 3.0
    
    // Media
    /// 풀 썸네일 가로(업로드용)
    static let poolThumbnailWidth: CGFloat = 1_024
    /// 풀 친구 썸네일 사이즈(업로드용)
    static let poolFriendThumbnailSize: CGSize = CGSize(width: 1_024, height: 1_024)
    /// JPEG 기본 퀄리티
    static let defaultJpegQuality: CGFloat = 0.8
    
    /// 관심사 프로필 최대 수
    static let maxNumOfProfiles: Int = 3
    
    /// 댓글 최대 글자 수
    static let maxLengthOfComment: Int = 1_000
    
    /// 검색 Debounce 타임
    static let searchDebounceMilliSeconds: Int = 500
    
    /// 키워드 최대 글자 수
    static let maxNumOfCharsOfKeyword: Int = 13
    
    /// 최대 키워드 태그 가능 수
    static let maxNumOfTagKeywords: Int = 3
    
}
