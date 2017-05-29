//
//  ViewController.swift
//  ACFloatingTextField
//
//  Created by Er Abhishek Chandani on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    let aTextField = ACFloatingTextfield()

    @IBOutlet weak var textFieldUsername: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        aTextField.frame = CGRect(x:20, y:300, width:UIScreen.main.bounds.width-40, height:45)
        aTextField.delegate = self
        aTextField.placeholder = "Password"
        aTextField.text = "Abhishk22580"

    }
    
    @IBAction func showError(_ sender: AnyObject) {
//        textFieldUsername.showError()
        aTextField.showErrorWithText(errorText: "Enter Valid Text")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
