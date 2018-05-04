//
//  PXDatePickerView.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum PXDatePickerViewClickedType: Int {
    case cancle = 0, confirm = 1
}
class PXDatePickerView: UIView {

    typealias PXDatePickerViewClickedHandler = (_ row: PXDatePickerViewClickedType, _ dateString: String) -> ()
    var datePickerViewClickedHandler: PXDatePickerViewClickedHandler!
    
    
    static func loadDatePickerView() -> PXDatePickerView{
        return Bundle.main.loadNibNamed("PXDatePickerView", owner: nil, options: nil)?.last as! PXDatePickerView
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancleAction(_ sender: UIButton) {
        datePickerViewClickedHandler(.cancle, getDateString())
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        datePickerViewClickedHandler(.confirm, getDateString())
    }
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = datePicker.date
        return formatter.string(from: date)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
    }
    
}
