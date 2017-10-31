//
//  ViewController.swift
//  ACFloatingTextField
//
//  Created by Er Abhishek Chandani on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var test1TextField: ACFloatingTextfield!
    
    let aTextField = ACFloatingTextfield()

   // @IBOutlet weak var textFieldUsername: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Storyboard
        test1TextField.lineColor = UIColor.yellow
        test1TextField.selectedLineColor = UIColor.orange
        test1TextField.placeHolderColor = UIColor.darkGray
        test1TextField.selectedPlaceHolderColor = UIColor.lightGray
        test1TextField.updateConfig()
        
        //Custom
        aTextField.frame = CGRect(x:20, y:300, width:UIScreen.main.bounds.width-40, height:45)
        aTextField.delegate = self
        aTextField.placeholder = "Pasggsword"
        aTextField.text = "Abhishk22580"
        self.view.addSubview(aTextField)

    }
    
    
    
    @IBAction func hideError(_ sender: Any) {
        aTextField.hideError()
    }
    
    @IBAction func showError(_ sender: AnyObject) {
        //        textFieldUsername.showError()
             // aTextField.showError()
        aTextField.showErrorWithText(errorText: "Enter Valhhggggggid Text")
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

