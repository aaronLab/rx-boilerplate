//
//  UITableView+Ext.swift
//
//  Created by Aaron Lee on 2021/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension UITableView {
    
    /// 기본 풀 및 리스트 설정
    func poolOrFriendListTableView() {
        backgroundColor = .clear
        separatorStyle = .none
        rowHeight = 44
        sectionHeaderHeight = 34
        keyboardDismissMode = .onDrag
    }
    
    /// 선택 가능 기본 풀 및 리스트 설정
    func selectablePoolOrFriendListTableView() {
        poolOrFriendListTableView()
        allowsMultipleSelection = true
    }
    
    /// 설정 테이블뷰
    func settingsTableView() {
        rowHeight = 48
        separatorStyle = .none
    }
    
    /// 알림 목록
    func notificationListTableView() {
        backgroundColor = .clear
        separatorStyle = .none
        rowHeight = 102
    }
    
    /// 피드 목록 스타일
    func stylingFeedList() {
        backgroundColor = .clear
        separatorStyle = .none
        keyboardDismissMode = .onDrag
        rowHeight = UITableView.automaticDimension
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    /// 헤더 바인딩
    func bindTableViewHeader() -> Observable<[Any]> {
        return rx.delegate.methodInvoked(#selector(delegate?.tableView(_:willDisplayHeaderView:forSection:)))
            .take(until: rx.deallocated)
    }
    
    /// 헤더 셋팅
    func configureHeader(_ event: [Any]) {
        guard let headerView = event[1] as? UITableViewHeaderFooterView else { return }
        
        // 배경
        for view in headerView.subviews {
            view.backgroundColor = .appColor(.white)
        }
        
        // 타이틀
        let attributedString = NSMutableAttributedString(string: headerView.textLabel?.text ?? "")
        attributedString.setFont(.font(.body5))
        
        // 글 타이틀
        let titleString = headerView.textLabel?.text?.filter { Int(String($0)) == nil }
        attributedString.setColor(color: .appColor(.black), forText: titleString)
        
        // 숫자
        let titleNumber = headerView.textLabel?.text?.filter { Int(String($0)) != nil }
        attributedString.setColor(color: .appColor(.black), forText: titleNumber)
        
        // 타이틀 텍스트
        headerView.textLabel?.attributedText = attributedString
    }
    
    /// 헤더 스페이싱 높이
    static func headerSpacingHeight(section: Int) -> CGFloat {
        if section == 0 {
            return 10.5
        }
        return 0
    }
    
    /// 헤더 뷰 바인드
    func bindTableViewHeader(bag: DisposeBag) {
        rx.delegate.methodInvoked(#selector(delegate?.tableView(_:willDisplayHeaderView:forSection:)))
            .take(until: rx.deallocated)
            .subscribe(onNext: { event in
                guard let headerView = event[1] as? UITableViewHeaderFooterView else { return }
                
                // 배경
                for view in headerView.subviews {
                    view.backgroundColor = .appColor(.white)
                }
                
                // 타이틀
                let attributedString = NSMutableAttributedString(string: headerView.textLabel?.text ?? "")
                attributedString.setFont(.font(.body5))
                
                // 글 타이틀
                let titleString = headerView.textLabel?.text?.filter { Int(String($0)) == nil }
                attributedString.setColor(color: .appColor(.black), forText: titleString)
                
                // 숫자
                let titleNumber = headerView.textLabel?.text?.filter { Int(String($0)) != nil }
                attributedString.setColor(color: .appColor(.black), forText: titleNumber)
                
                // 타이틀 텍스트
                headerView.textLabel?.attributedText = attributedString
                
            })
            .disposed(by: bag)
    }
    
    /// 헤더 뷰 바인드
    func bindTableViewPlainHeader(font: Font? = nil, bag: DisposeBag) {
        rx.delegate.methodInvoked(#selector(delegate?.tableView(_:willDisplayHeaderView:forSection:)))
            .take(until: rx.deallocated)
            .subscribe(onNext: { event in
                guard let headerView = event[1] as? UITableViewHeaderFooterView else { return }
                
                // 배경
                for view in headerView.subviews {
                    view.backgroundColor = .appColor(.white)
                }
                
                // 헤더
                if let font = font {
                    headerView.textLabel?.font(font)
                } else {
                    headerView.textLabel?.font(.body5)
                }
                
                headerView.textLabel?.textColor = .appColor(.black)
            })
            .disposed(by: bag)
    }
    
    /// 가장 아래로 스크롤
    func scrollToBottom(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else { return }
            
            var section = max(self.numberOfSections - 1, 0)
            var row = max(self.numberOfRows(inSection: section) - 1, 0)
            var indexPath = IndexPath(row: row, section: section)
            
            while !self.indexPathIsValid(indexPath) {
                section = max(section - 1, 0)
                row = max(self.numberOfRows(inSection: section) - 1, 0)
                indexPath = IndexPath(row: row, section: section)
                
                if indexPath.section == 0 {
                    indexPath = IndexPath(row: 0, section: 0)
                    break
                }
            }
            
            guard self.indexPathIsValid(indexPath) else { return }
            
            if animated {
                UIView.animate(withDuration: Constants.animationDefaultDuration) {
                    self.scrollToRow(at: indexPath, at: .bottom, animated: false)
                } completion: { _ in
                    completion?()
                }
                return
            }
            
            self.scrollToRow(at: indexPath, at: .bottom, animated: false)
            completion?()
        }
    }
    
    /// 가장 위로 스크롤
    func scrollToTop(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.indexPathIsValid(indexPath) {
                
                if animated {
                    UIView.animate(withDuration: Constants.animationDefaultDuration) {
                        self.scrollToRow(at: indexPath, at: .top, animated: false)
                    } completion: { _ in
                        completion?()
                    }
                    return
                }
                
                self.scrollToRow(at: indexPath, at: .top, animated: false)
                completion?()
            }
        }
    }
    
    /// 셀 있는지 판단
    func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
    
    /// 추가 로딩 핸들러
    func handleLoadMoreIndicator(isLoadingMore: Bool) {
        if isLoadingMore {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0,
                                   y: 0,
                                   width: bounds.width,
                                   height: rowHeight)
            tableFooterView = spinner
            tableFooterView?.isHidden = false
        } else {
            guard let spinner = tableFooterView as? UIActivityIndicatorView else { return }
            spinner.stopAnimating()
            tableFooterView?.isHidden = true
        }
        
        UIView.animate(withDuration: Constants.transitionDefaultDuration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    /// 하단 Activity Control
    func addBottomActivityIndicator(with indicator: UIActivityIndicatorView) {
        let copy = indicator
        copy.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 44)
        tableFooterView = copy
        copy.isHidden = true
    }
    
}
