//
//  ViewController.swift
//  ACFloatingTextField
//
//  Created by Macintosh on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var textFieldUsername: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aTextField = ACFloatingTextfield()
        aTextField.frame = CGRectMake(20, 300, CGRectGetWidth(UIScreen.mainScreen().bounds)-40, 45)
        aTextField.delegate = self
        aTextField.placeholder = "Password"
        self.view.addSubview(aTextField)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

