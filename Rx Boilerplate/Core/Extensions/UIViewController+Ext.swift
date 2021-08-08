//
//  UIViewController+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import UIKit
import Lottie

extension UIViewController {
    
    /// 배경을 블러처리
    func addBlur() {
        let blurFx = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurFxView = UIVisualEffectView(effect: blurFx)
        blurFxView.frame = view.bounds
        blurFxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurFxView, at: 0)
    }
    
    /// 알림 보여주기
    func showAlert(title: String? = "NetworkErrorAlertTitle".localized(comment: "오류"),
                   message: String? = "NetworkErrorAlertDescription".localized(comment: "다시 한 번 시도해주세요\n지속적으로 문제가 해결되지 않을 경우 이메일\n(witi@witi.co.kr)로 문의주세요"),
                   actions: [UIAlertAction]? = [UIAlertAction(title: "Confirm".localized(comment: "확인"),
                                                              style: .default)],
                   completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            
            // 타이틀 폰트 + 색상
            alert.setValue(NSAttributedString(string: alert.title!,
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold),
                                                           NSAttributedString.Key.foregroundColor: UIColor.black]),
                           forKey: "attributedTitle")
            
            // 메세지 폰트 + 색상
            alert.setValue(NSAttributedString(string: alert.message!,
                                              attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular),
                                                           NSAttributedString.Key.foregroundColor: UIColor.black]),
                           forKey: "attributedMessage")
            
            // 액션 추가
            actions?.forEach {
                // 타이틀 색상
                if $0.style == .cancel {
                    $0.setValue(UIColor.lightGray, forKey: "titleTextColor")
                } else {
                    $0.setValue(UIColor.appColor(.black) ?? UIColor.red, forKey: "titleTextColor")
                }
                alert.addAction($0)
            }
            
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white
            
            self.present(alert, animated: true, completion: completion)
            
        }
        
    }
    
    /// 잠김 계정 알림
    func showLockAlert() {
        let action = UIAlertAction(title: "AccountLockAlertAction".localized(comment: "고객센터로 문의하기"),
                                   style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
            UIApplication.dial(number: "050713333905")
        }
        showAlert(title: "AccountLockAlertTitle".localized(comment: "Rippler 본인 인증에 실패하였습니다"),
                  message: "AccountLockAlertDescription".localized(comment: "해당 계정이 잠금처리되었습니다\n잠금해제 하시려면 문의하시기 바랍니다"),
                  actions: [action],
                  completion: nil)
    }
    
    /// 이중 인증 데이터 없음 알림
    func showNoTwoFactorDataAlert() {
        let action = UIAlertAction(title: "AccountLockAlertAction".localized(comment: "고객센터로 문의하기"),
                                   style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
            UIApplication.dial(number: "050713333905")
        }
        showAlert(title: "AccountLockAlertTitle".localized(comment: "Rippler 본인 인증에 실패하였습니다"),
                  message: "AccountLockAlertDescription".localized(comment: "해당 계정이 잠금처리되었습니다\n잠금해제 하시려면 문의하시기 바랍니다"),
                  actions: [action],
                  completion: nil)
    }
    
    /// 연락처 권한 알림
    func showContactPermissionAlert() {
        let actions = permissionActions()
        showAlert(title: "ContactPermissionAlertTitle".localized(comment: "연락처 접근 권한이 필요해요!"),
                  message: "ContactPermissionAlertBody".localized(comment: "해당 기능을 자유롭게 즐기기\n위해 연락처 접근 권한이 필요해요."),
                  actions: actions)
    }
    
    /// 카메라 권한 알림
    func showCameraPermissionAlert() {
        let actions = permissionActions()
        showAlert(title: "CameraPermissionAlertTitle".localized(comment: "'설정 > Rippler > 카메라 권한 ON'\n카메라 접근 권한을 켜주세요 :)"),
                  message: "CameraPermissionAlertBody".localized(comment: "카메라 권한 허용해야 사진과 비디오를 촬영할 수 있어요😝권한 설정하러 가볼까요~?"),
                  actions: actions)
    }
    
    /// 알림 권한 알림
    func showLibraryPermissionAlert() {
        let actions = permissionActions()
        showAlert(title: "LibraryPermissionAlertTitle".localized(comment: "설정 > Rippler > 앨범 권한 ON'\n앨범 접근 권한을 켜주세요 :)"),
                  message: "LibraryPermissionAlertBody".localized(comment: "앨범 권한 허용해야 사진과 비디오를 업로드할 수 있어요😝권한 설정하러 가볼까요~?"),
                  actions: actions)
    }
    
    /// 권한 알림 액션
    private func permissionActions() -> [UIAlertAction] {
        let cancel = UIAlertAction(title: "Cancel".localized(comment: "취소하기"),
                                   style: .cancel)
        let confirm = UIAlertAction(title: "Change".localized(comment: "변경하기"),
                                   style: .default,
                                   handler: { (action: UIAlertAction!) in
                                    if let settingUrl = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(settingUrl)
                                    } else {
                                        print("Setting URL invalid")
                                    }
                                   })
        return [cancel, confirm]
    }
    
    /// 로딩 뷰 추가
    func addLoadingView(with loadingView: UIView) {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        view.bringSubviewToFront(loadingView)
    }
    
    /// 뷰 컨트롤러 변경
    func nestViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        setNeedsStatusBarAppearanceUpdate()
        
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
        
        completion?()
    }
    
    /// 뷰 컨트롤러 추가
    func embed(in viewController: UIViewController, view: UIView) {
        viewController.addChild(self)
        view.addSubview(self.view)
        viewController.didMove(toParent: self)
    }
    
    /// Alert Sheet 보여주기
    /// - Parameters:
    ///   - title: 알림 타이틀
    ///   - message: 알림 메세지
    ///   - actions: 알림 액션
    ///   - needCancel: 취소 버튼 자동 생성
    func showAlertSheet(title: String? = nil, message: String? = nil, actions: [UIAlertAction] = [], needCancel: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        actions.forEach {
            alert.addAction($0)
        }
        
        if needCancel {
            let cancelAction = UIAlertAction(title: "Cancel".localized(comment: "취소"), style: .cancel)
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true)
    }
    
    /// 풀 중복생성 알림
    func showExistingPoolError(confirmAction: ((UIAlertAction) -> Void)? = nil) {
        let confirmAction = UIAlertAction(title: "Confirm".localized(comment: "확인"),
                                          style: .default,
                                          handler: confirmAction)
        
        showAlert(title: "NetworkErrorAlertTitle".localized(comment: "오류"),
                  message: "ExistingPoolErrorBody".localized(comment: "중복된 이름을 가진 풀이 있어요.\n확인 후 다시 시도해주세요."),
                  actions: [confirmAction])
    }
    
    /// 공지사항 알림
    func showNoticeAlert(completion: @escaping () -> Void) {
        RemoteConfigManager.shared.fetchAppInfo { [weak self] appInfo in
            
            let notice = appInfo?.noticeInfo
            
            if notice?.title == nil && notice?.description == nil && notice?.shouldClose == false {
                completion()
                return
            }
            
            let title = notice?.title
            let description = notice?.description
            let shouldClose = notice?.shouldClose == true
            
            let confirmAction = UIAlertAction(title: "Confirm".localized(comment: "확인"),
                                              style: .default) { _ in
                if shouldClose {
                    exit(-1)
                }
                
                completion()
                
            }
            
            self?.showAlert(title: title,
                            message: description,
                            actions: [confirmAction])
            
        }
    }
    
    func setUIInterfaceOrientation(_ value: UIInterfaceOrientation) {
        UIDevice.current.setValue(value.rawValue, forKey: "orientation")
    }
    
}
