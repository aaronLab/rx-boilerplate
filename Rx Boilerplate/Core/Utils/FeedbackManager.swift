//
//  FeedbackManager.swift
//
//  Created by Aaron Lee on 2021/05/25.
//

import UIKit

/// 피드백(탭틱) 매니저
struct FeedbackManager {
    
    // MARK: - Public Properties
    
    static let shared = FeedbackManager()
    
    // MARK: - Init
    
    private init() { }
    
    /// 알림 피드백
    func notificationFeedack(_ type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.notificationOccurred(type)
    }
    
    /// 임팩트 피드백
    func impactFeedback(_ type: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let impactGenerator = UIImpactFeedbackGenerator(style: type)
        impactGenerator.impactOccurred()
    }
    
}
