//
//  UIPanGestureRecognizer+Ext.swift
//
//  Created by Aaron Lee on 2021/06/11.
//

import UIKit

extension UIPanGestureRecognizer {
    
    /// 이동 정보
    public struct PanGestureDirection: OptionSet {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        // 위
        static let up = PanGestureDirection(rawValue: 1 << 0)
        // 아래
        static let down = PanGestureDirection(rawValue: 1 << 1)
        // 왼
        static let left = PanGestureDirection(rawValue: 1 << 2)
        // 오른
        static let right = PanGestureDirection(rawValue: 1 << 3)
    }
    
    /// 방향 반환
    private func getDirectionBy(velocity: CGFloat, greater: PanGestureDirection, lower: PanGestureDirection) -> PanGestureDirection {
        if velocity == 0 {
            return []
        }
        return velocity > 0 ? greater : lower
    }
    
    /// 방향
    public func direction(in view: UIView) -> PanGestureDirection {
        let velocity = self.velocity(in: view)
        let yDirection = getDirectionBy(velocity: velocity.y, greater: PanGestureDirection.down, lower: PanGestureDirection.up)
        let xDirection = getDirectionBy(velocity: velocity.x, greater: PanGestureDirection.right, lower: PanGestureDirection.left)
        return xDirection.union(yDirection)
    }
    
}
