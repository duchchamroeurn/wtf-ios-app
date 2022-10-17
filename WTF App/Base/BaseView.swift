//
//  BaseView.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

class BaseViewView: UIView {
    
    public var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibInit()
        contentView?.frame = self.bounds
        contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let view = contentView else { return }
        addSubview(view)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        xibInit()
        contentView?.fixInView(self)
        commonInit()
    }
    
    private func xibInit() {
        guard let name = self.className else {
            return
        }
        
        contentView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView
        
    }
    
    public func commonInit() {}
    
}

extension NSObject {
    public var className: String? {
        return NSStringFromClass(classForCoder).components(separatedBy: ".").last
    }
}


fileprivate extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
