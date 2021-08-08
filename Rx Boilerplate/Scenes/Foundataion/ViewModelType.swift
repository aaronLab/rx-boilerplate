//
//  ViewModelType.swift
//  Rippler
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation
import RxSwift

/// 뷰모델 프로토콜
protocol ViewModelType {
    
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var apiSession: APIService { get }
    
    var bag: DisposeBag { get }
    
    /// Dependency
    var dependency: Dependency { get }
    
    /// Input
    var input: Input { get }
    
    /// Output
    var output: Output { get }
    
    /// Input 리스너 초기화
    func bindInput()
    
}
