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

    @IBOutlet weak var tf1: ACFloatingTextfield!
    @IBOutlet weak var tf2: ACFloatingTextfield!
    @IBOutlet weak var tf3: ACFloatingTextfield!
    // @IBOutlet weak var textFieldUsername: ACFloatingTextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        aTextField.frame = CGRect(x:20, y:300, width:UIScreen.main.bounds.width-40, height:45)
        aTextField.delegate = self
        aTextField.placeholder = "Pasggsword"
        aTextField.text = "Abhishk22580"
        aTextField.lineColor = UIColor.brown
        aTextField.selectedLineColor = UIColor.brown
        
        aTextField.placeHolderColor = UIColor.cyan
        aTextField.selectedPlaceHolderColor = UIColor.orange
        self.view.addSubview(aTextField)
    }
    
    @IBAction func hideError(_ sender: Any) {
        tf1.hideError()
        tf2.hideError()
        tf3.hideError()
        aTextField.hideError()
    }
    
    @IBAction func showError(_ sender: AnyObject) {
        tf1.showErrorWithText(errorText: "Enter Valhhggggggid Text")
        tf2.showErrorWithText(errorText: "Enter Valhhggggggid Text")
        tf3.showErrorWithText(errorText: "Enter Valhhggggggid Text")
        aTextField.showErrorWithText(errorText: "Enter Valhhggggggid Text")
    }
    
    @IBAction func changeErrorColor(_ sender: Any) {
        tf1.errorTextColor = getRandomColor()
        tf2.errorTextColor = getRandomColor()
        tf3.errorTextColor = getRandomColor()
        aTextField.errorTextColor = getRandomColor()
        
        tf1.errorLineColor = getRandomColor()
        tf2.errorLineColor = getRandomColor()
        tf3.errorLineColor = getRandomColor()
        aTextField.errorLineColor = getRandomColor()
    }
    @IBAction func chanagePlacecholderColor(_ sender: Any) {
        
        tf1.placeHolderColor = getRandomColor()
        tf2.placeHolderColor = getRandomColor()
        tf3.placeHolderColor = getRandomColor()
        aTextField.placeHolderColor = getRandomColor()
        
        tf1.selectedPlaceHolderColor = getRandomColor()
        tf2.selectedPlaceHolderColor = getRandomColor()
        tf3.selectedPlaceHolderColor = getRandomColor()
        aTextField.selectedPlaceHolderColor = getRandomColor()

    }
    
    @IBAction func changeLineColor(_ sender: Any) {
        tf1.lineColor = getRandomColor()
        tf2.lineColor = getRandomColor()
        tf3.lineColor = getRandomColor()
        aTextField.lineColor = getRandomColor()
        
        tf1.selectedLineColor = getRandomColor()
        tf2.selectedLineColor = getRandomColor()
        tf3.selectedLineColor = getRandomColor()
        aTextField.selectedLineColor = getRandomColor()

    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
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

