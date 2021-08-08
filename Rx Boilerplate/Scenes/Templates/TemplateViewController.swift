//
//  TemplateViewController.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

#if DEBUG

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

/// <#설명#>
class TemplateViewController: PortraitViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()
    
    private let viewModel = TemplateViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSubViews()
        bindRx()
    }
    
    // MARK: - Helpers
    
}

// MARK: - BaseViewController

extension TemplateViewController: BaseViewController {
    
    func configureView() {
        
    }
    
    func configureSubViews() {
        
    }
    
}

// MARK: - BindableViewController

extension TemplateViewController: BindableViewController {
    
    func bindRx() {
        
    }
    
}

#endif
