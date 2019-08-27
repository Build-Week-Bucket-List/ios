//
//  SelectDateViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func itemDateWasChosen(selectedDate: Date)
}

class SelectDateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var delegate: DatePickerDelegate?
    
    @IBAction func confirmTapped(_ sender: Any) {
        delegate?.itemDateWasChosen(selectedDate: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
