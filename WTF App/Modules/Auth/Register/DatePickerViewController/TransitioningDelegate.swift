//
//  TransitioningDelegate.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 17/10/22.
//

import UIKit

enum PresentationControllerType {
    case customHeight(height: CGFloat)
}

final class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public var didDismiss: ()->() = {}
    
    private var type:PresentationControllerType
    
    init(type: PresentationControllerType) {
        self.type = type
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch type {
        case .customHeight(let customH):
            let vc = CustomPresentController(presentedViewController: presented, presenting: presenting)
            vc.customH = customH
            vc.didDismiss = didDismiss
            return vc
        }
        
    }
}
