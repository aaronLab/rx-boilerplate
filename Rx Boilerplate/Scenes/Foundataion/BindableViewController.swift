//
//  BindableViewController.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation

/// 뷰모델 바인딩 프로토콜
protocol BindableViewController {
    
    /// Rx를 활용하여 View Model과 바인딩
    func bindRx()
    
}
