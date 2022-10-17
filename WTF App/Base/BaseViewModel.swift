//
//  BaseViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

class BaseViewModel: NSObject {
    
    public var loadingState: Observable<Bool?> = Observable(nil)
    public var errorUnreachable: Observable<Bool> = Observable(false)

}
