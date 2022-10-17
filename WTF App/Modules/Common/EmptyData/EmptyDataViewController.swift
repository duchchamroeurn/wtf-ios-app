//
//  EmptyDataViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 17/10/22.
//

import UIKit

final class EmptyDataViewController: BaseViewController {
    
    @IBOutlet private weak var labelMessage: UILabel!
    public var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelMessage.text = message
    }

}
