//
//  BaseViewController.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import UIKit
import Lottie

/// 베이스 뷰 컨트롤러 프로토콜
protocol BaseViewController {
    
    /// View에 SubView들을 삽입하여 뷰를 초기화
    func configureView()
    
    /// SubView들의 제약조건 설정 등 세부 사항을 초기화
    func configureSubViews()
    
}

/// 세로 뷰
class PortraitViewController: UIViewController  {
    
    /// 로딩 뷰
    
    var loadingView = UIView()
    
    // MARK: - Private Properties
    
    private var isInit = false
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        addLoadingView(with: loadingView)
        loadingView.layer.zPosition = 9
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        Application.shouldSupportAllOrientation = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isInit {
            // 로딩 뷰 추가
            view.bringSubviewToFront(loadingView)
            isInit.toggle()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func buildAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) -> UIAlertController {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        guard let actions = actions else { return alertC }
        
        actions.forEach { alertC.addAction($0) }
        
        return alertC
        
    }
    
}

/// 가로 지원 뷰
class HorizontableViewController: PortraitViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shouldSupportAllOrientation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Application.shouldSupportAllOrientation = false
        
        setUIInterfaceOrientation(.portrait)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

/// 세로 테이블 뷰
class PortraitTableViewController: UITableViewController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shouldSupportAllOrientation = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func buildAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) -> UIAlertController {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        guard let actions = actions else { return alertC }
        
        actions.forEach { alertC.addAction($0) }
        
        return alertC
        
    }
    
}

/// 가로 지원 테이블 뷰
class HorizontableTableViewController: PortraitTableViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shouldSupportAllOrientation = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

/// 세로 콜렉션 뷰
class PortraitCollectionViewController: UICollectionViewController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shouldSupportAllOrientation = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func buildAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) -> UIAlertController {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        guard let actions = actions else { return alertC }
        
        actions.forEach { alertC.addAction($0) }
        
        return alertC
        
    }
    
}

/// 가로 지원 콜렉션 뷰
class HorizontableCollectionViewController: PortraitCollectionViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Application.shouldSupportAllOrientation = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}
