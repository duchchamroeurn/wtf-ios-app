//
//  Observable.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import Foundation

final class Observable<T> {
    
    typealias Listener = (T) -> Void
    
    public var listener: Listener?
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
