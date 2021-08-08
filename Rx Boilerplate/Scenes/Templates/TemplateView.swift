//
//  TemplateView.swift
//
//  Created by Aaron Lee on 2021/07/29.
//

#if DEBUG

import UIKit
import SnapKit
import Then

/// <#설명#>
class TemplateView: UIView {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        
    }
    
}

#endif
