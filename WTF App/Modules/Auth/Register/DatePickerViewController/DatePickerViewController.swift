//
//  DatePickerViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

protocol DatePickerViewControllerDelegate: NSObject {
    func didSelectedDate(datePicker: UIDatePicker, date: Date)
}

final class DatePickerViewController: BaseViewController {

    @IBOutlet private weak var datePickerView: UIDatePicker!
    
    public weak var delegate: DatePickerViewControllerDelegate?
    public var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        datePickerView.maximumDate = Date()
        datePickerView.date = selectedDate
    }
    
    @IBAction private func buttonCancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction private func buttonDoneTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectedDate(datePicker: self.datePickerView, date: self.datePickerView.date)
        }
    }
    

}
