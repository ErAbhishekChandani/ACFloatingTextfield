//
//  ViewController.swift
//  ACFloatingTextField
//
//  Created by Er Abhishek Chandani on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var textFieldUsername: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aTextField = ACFloatingTextfield()
        aTextField.frame = CGRect(x:20, y:300, width:UIScreen.main.bounds.width-40, height:45)
        aTextField.delegate = self
        aTextField.placeholder = "Password"
        self.view.addSubview(aTextField)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

