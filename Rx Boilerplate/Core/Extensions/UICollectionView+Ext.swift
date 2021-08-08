//
//  UICollectionView+Ext.swift
//
//  Created by Aaron Lee on 2021/06/03.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension UICollectionView {
    
    var lastSection: Int {
        return numberOfSections - 1
    }
    
    var lastIndexPath: IndexPath? {
        guard lastSection >= 0 else {
            return nil
        }
        
        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else {
            return nil
        }
        
        return IndexPath(item: lastItem, section: lastSection)
    }
    
    func scrollToBottom(animated: Bool = true) {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
    }
    
    func scrollToRight(animated: Bool = true) {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        scrollToItem(at: lastIndexPath, at: .right, animated: animated)
    }
    
    /// 바텀 스피너 추가
    // MY-MARK: UICollectionReusableView.self 부분 클래스 변경
    func addBottomSpinner(spinner: UIActivityIndicatorView,
                          withReuseIdentifier: String) {
        register(UICollectionReusableView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: withReuseIdentifier)
        
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
        
        (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: bounds.width, height: 0)
    }
    
    /// 스피너 작동
    func animateSpinner(spinner: UIActivityIndicatorView, show: Bool) {
        if show {
            if !spinner.isAnimating {
                spinner.startAnimating()
            }
            
            (collectionViewLayout as? UICollectionViewFlowLayout)?
                .footerReferenceSize = CGSize(width: bounds.width,
                                              height: 44)
            return
        }
        
        if spinner.isAnimating {
            spinner.stopAnimating()
        }
        
        (collectionViewLayout as? UICollectionViewFlowLayout)?
            .footerReferenceSize = CGSize(width: bounds.width,
                                          height: 0)
    }
    
    /// Footer 뷰
    func bottomSupplementaryView(kind: String, identifier: String, indexPath: IndexPath, spinner: UIActivityIndicatorView) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: identifier,
                                                          for: indexPath)
            footer.addSubview(spinner)
            spinner.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 44)
            return footer
        }
        
        return UICollectionReusableView()
    }
    
}
