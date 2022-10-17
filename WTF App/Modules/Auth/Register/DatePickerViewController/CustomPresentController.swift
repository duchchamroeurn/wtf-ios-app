//
//  CustomPresentController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 17/10/22.
//

import UIKit

final class CustomPresentController: UIPresentationController {
    public var customH: CGFloat = 0
    var velocity:CGPoint = .zero,
        endPoint:CGPoint = .zero,
        _dimmedView: UIView?
    
    var dimmedView:UIView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(sender: )))
        
        if let view = _dimmedView {
            view.addGestureRecognizer(tapGesture)
            return view
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerView?.bounds.width ?? 0, height: containerView?.bounds.height ?? 0))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addGestureRecognizer(tapGesture)
        
        _dimmedView = view
        
        return view
    }
    
    public var didDismiss: (()->()) = {}
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true) {
            self.didDismiss()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewHeight = containerView?.frame.height ?? 0,
            containerViewWidth = containerView?.frame.width ?? 0
        return CGRect(x: 0, y: containerViewHeight - customH, width: containerViewWidth, height: customH)
    }
    
    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            
            dimmedView.alpha = 0
            containerView.addSubview(dimmedView)
            dimmedView.addSubview(presentedViewController.view)
            
            coordinator.animate(alongsideTransition: { (context) -> Void in
                self.dimmedView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let cordinator = presentingViewController.transitionCoordinator {
            cordinator.animate(alongsideTransition: { (context) in
                self.dimmedView.alpha = 0
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmedView.removeFromSuperview()
            _dimmedView = nil
        }
    }
}
