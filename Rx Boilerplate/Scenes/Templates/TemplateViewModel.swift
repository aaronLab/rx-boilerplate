//
//  TemplateViewModel.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

#if DEBUG

import Foundation
import RxSwift
import RxCocoa

/// <#설명#>
final class TemplateViewModel: ViewModelType {
    
    var apiSession: APIService = APISession()
    var bag = DisposeBag()
    var dependency = Dependency()
    var input = Input()
    var output = Output()
    
    // MARK: - Dependency
    
    struct Dependency {
        
    }
    
    // MARK: - Input
    
    struct Input {
        
    }
    
    // MARK: - Output
    
    struct Output {
        
    }
    
    // MARK: - Init
    
    init() {
        bindInput()
    }
    
    deinit {
        bag = DisposeBag()
    }
    
}

// MARK: - Helpers

extension TemplateViewModel {
    
}

// MARK: - Input

extension TemplateViewModel {
    
    func bindInput() {
        
    }
    
}

#endif
