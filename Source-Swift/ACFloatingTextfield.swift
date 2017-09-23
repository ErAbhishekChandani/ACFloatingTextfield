//
//  ACFloatingTextfield.swift
//  ACFloatingTextField
//
//  Created by Er Abhishek Chandani on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

@IBDesignable
@objc open class ACFloatingTextfield: UITextField {

     fileprivate var bottomLineView : UIView?
     fileprivate var labelPlaceholder : UILabel?
     fileprivate var labelErrorPlaceholder : UILabel?
     fileprivate var showingError : Bool = false

     /// Disable Floating Label when true.
     @IBInspectable open var disableFloatingLabel : Bool = false
    
     /// Shake Bottom line when Showing Error ?
     @IBInspectable open var shakeLineWithError : Bool = true
    
     /// Change Bottom Line Color.
     @IBInspectable open var lineColor : UIColor = UIColor.black
    
     /// Change line color when Editing in textfield
     @IBInspectable open var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
     /// Change placeholder color.
     @IBInspectable open var placeHolderColor : UIColor = UIColor.lightGray
    
     /// Change placeholder color while editing.
     @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
     /// Change Error Text color.
     @IBInspectable open var errorTextColor : UIColor = UIColor.red

     /// Change Error Line color.
     @IBInspectable open var errorLineColor : UIColor = UIColor.red
    
    //MARK:- Set Text
    override open var text:String?  {
        didSet {
            if showingError {
                self.hideErrorPlaceHolder()
            }
            floatTheLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet {
            if newValue != "" {
                self.labelPlaceholder?.text = newValue
            }
        }
    }
    
    open var errorText : String? {
        willSet {
            self.labelErrorPlaceholder?.text = newValue
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));
    }

    // MARK:- Loading From NIB
    override open func awakeFromNib() {
        super.awakeFromNib()
         self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }

    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }

    //MARK:- UITextfield Becomes First Responder
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override open func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }

    //MARK:- Show Error Label
    public func showError() {
        showingError = true;
        self.showErrorPlaceHolder();
    }
    public func hideError() {
        showingError = false;
        self.hideErrorPlaceHolder();
        floatTheLabel()
    }

    public func showErrorWithText(errorText : String) {
        self.errorText = errorText;
        showingError = true;
        self.showErrorPlaceHolder();
    }


}

fileprivate extension ACFloatingTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        
        self.clipsToBounds = true
        /// Adding Bottom Line
        addBottomLine()
        
        /// Placeholder Label Configuration.
        addFloatingLabel()
        
        /// Checking Floatibility
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine(){
        
        if bottomLineView?.superview != nil {
            var bottomLineFrame = bottomLineView?.frame ?? CGRect.zero
            bottomLineFrame.size.width = self.frame.width
            bottomLineView?.frame = bottomLineFrame
            return
        }
        
        bottomLineView?.removeFromSuperview()
        //Bottom Line UIView Configuration.
        bottomLineView = UIView(frame: CGRect(x:0, y:self.frame.height-1, width:self.frame.width, height:2))
        bottomLineView?.backgroundColor = lineColor;
        
        if bottomLineView != nil {
            self.addSubview(bottomLineView!)
        }
        
    }
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){
        
        if labelPlaceholder?.superview != nil {
            var labelFrame = labelPlaceholder?.frame ?? CGRect.zero
            labelFrame.origin.x = 5
            labelFrame.size.width = self.frame.width
            labelPlaceholder?.frame = labelFrame
            return
        }
        labelPlaceholder?.removeFromSuperview()
        
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.frame = CGRect(x:5, y:0, width:self.frame.size.width-5, height:self.frame.height)
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = self.font
        labelPlaceholder?.isHidden = true
        self.setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        
    }
    
    
    func addErrorPlaceholderLabel() -> Void {

        labelErrorPlaceholder?.removeFromSuperview()
        labelErrorPlaceholder = UILabel()
        labelErrorPlaceholder?.text = self.errorText
        labelErrorPlaceholder?.textAlignment = self.textAlignment
        labelErrorPlaceholder?.textColor = errorTextColor
        labelErrorPlaceholder?.font = UIFont(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        labelErrorPlaceholder?.sizeToFit()
        labelErrorPlaceholder?.isHidden = true;
        if labelErrorPlaceholder != nil {
            self.addSubview(labelErrorPlaceholder!)
        }

        var frame = labelErrorPlaceholder!.frame
        frame.origin.x = self.bounds.maxX - frame.width
        labelErrorPlaceholder?.frame = frame

    }
    
    func showErrorPlaceHolder() {
        
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = self.frame.height-2
        if self.errorText != nil && self.errorText != "" {
            self.addErrorPlaceholderLabel()

            labelErrorPlaceholder?.isHidden = false
            var frame = labelErrorPlaceholder?.frame
            let localFrame = frame;
            frame?.origin.y -= (localFrame?.height ?? 0)!
            labelErrorPlaceholder?.frame = frame!
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                frame?.origin.y = 0
                self.labelErrorPlaceholder?.frame = frame!
                self.bottomLineView?.frame  =  bottomLineFrame!;

                }, completion: nil)
        }else{

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.bottomLineView?.frame  =  bottomLineFrame!;
                }, completion: nil)
        }
        
        if shakeLineWithError {
            bottomLineView?.shake()
        }
        
    }
    
    func hideErrorPlaceHolder(){
        showingError = false;
        
        if errorText == nil || errorText == "" {
            return
        }
        
        var labelErrorFrame = labelErrorPlaceholder?.frame;
        let localLabelErrorFrame = labelErrorFrame;
        labelErrorFrame?.origin.y -= (localLabelErrorFrame?.height ?? 0)!
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.labelErrorPlaceholder?.frame = labelErrorFrame!
            }) { (finished) in
                self.labelErrorPlaceholder?.removeFromSuperview()
        }
        
    }

    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        
        if self.text == "" && self.isFirstResponder {
            
            floatPlaceHolder(selected: true)
            
        }else if self.text == "" && !self.isFirstResponder {
            
            resignPlaceholder()
            
        }else if self.text != "" && !self.isFirstResponder  {
            
            floatPlaceHolder(selected: false)
            
        }else if self.text != "" && self.isFirstResponder {
            
            floatPlaceHolder(selected: true)
        }
        
    }
    
    //MARK:- Upadate and Manage Subviews
    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;
        self.initialize()
    }
    
    //MARK:- Float UITextfield Placeholder Label
    func floatPlaceHolder(selected:Bool) -> Void {
        
        labelPlaceholder?.isHidden = false
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.size.width = self.frame.width
        if selected {
            bottomLineView?.backgroundColor = selectedLineColor
            self.labelPlaceholder?.textColor = self.selectedPlaceHolderColor
            bottomLineFrame?.origin.y = self.frame.height-2
            self.setValue(self.selectedPlaceHolderColor, forKeyPath: "_placeholderLabel.textColor")

        } else {
            bottomLineView?.backgroundColor = lineColor;
            bottomLineFrame?.origin.y = self.frame.height-1
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")

        }

        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            
            return
        }
        
        var labelFrame = labelPlaceholder?.frame
        labelFrame?.size.height = 14.33

        UIView.animate(withDuration: 0.2, animations: {
            self.labelPlaceholder?.frame = labelFrame!;
            self.labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 12)
            self.bottomLineView?.frame  =  bottomLineFrame!;
        })
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {

        self.setValue(self.placeHolderColor, forKeyPath: "_placeholderLabel.textColor")

        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = self.frame.height-1
        
        bottomLineView?.backgroundColor = lineColor;
        
        if disableFloatingLabel {
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            return
        }
        
        let labelFrame = CGRect(x:5, y:0, width:self.frame.size.width-5, height:self.frame.size.height)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.frame = labelFrame
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.bottomLineView?.frame  =  bottomLineFrame!;
        }) { (finished) in
            self.labelPlaceholder?.isHidden = true
            self.placeholder = self.labelPlaceholder?.text
        }
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {
        if showingError {
            self.hideErrorPlaceHolder()
        }
        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }
}

//MARK:- Shake
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
