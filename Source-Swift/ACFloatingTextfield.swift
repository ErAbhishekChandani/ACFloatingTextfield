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
    
     @IBInspectable open var disableFloatingLabel : Bool = false
    
     @IBInspectable open var lineColor : UIColor = UIColor.black
    
     @IBInspectable open var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
     @IBInspectable open var placeHolderColor : UIColor = UIColor.lightGray
    
     @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
    @IBInspectable open var errorTextColor : UIColor = UIColor.red

    @IBInspectable open var errorLineColor : UIColor = UIColor.red

    
    //MARK:- Set Text
    override open var text:String?  {
        didSet {
            floatTheLabel()
            checkForDefaulLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet {
            self.labelPlaceholder?.text = newValue
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
        if (showingError) {
            return CGRect(x:0, y:0, width:bounds.size.width, height:bounds.size.height);
        }else{
            return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
        }
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if (showingError) {
            return CGRect(x:0, y:0, width:bounds.size.width, height:bounds.size.height);
        }else{
            return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
        }
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
    func public showError() {
        showingError = true;
        self.upadteTextField(frame: self.frame)
        self.showErrorPlaceHolder();
    }
    
    func public showErrorWithText(errorText : String) {
        self.errorText = errorText;
        showingError = true;
        self.upadteTextField(frame: self.frame)
        self.showErrorPlaceHolder();
    }


}

fileprivate extension ACFloatingTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        
        /// HIDE DEFAULT PLACEHOLDER LABEL OF UITEXTFIELD
        checkForDefaulLabel()
        
        /// Adding Bottom Line
        addBottomLine()
        
        /// Placeholder Label Configuration.
        addFloatingLabel()
        
        /// Adding Error Label
        if (showingError) {
            if (self.errorText == "" || self.errorText == nil) {
                self.errorText = "Error";
            }
            self.addErrorPlaceholderLabel()
        }

        /// Checking Floatibility
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine(){
        
        bottomLineView?.removeFromSuperview()
        
        //Bottom Line UIView Configuration.
        bottomLineView = UIView(frame: CGRect(x:0, y:self.frame.height-1, width:self.frame.width, height:2))
        bottomLineView?.backgroundColor = lineColor;
        bottomLineView?.tag = 20;
        
        if bottomLineView != nil {
            self.addSubview(bottomLineView!)
        }
        
    }
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){
        
        labelPlaceholder?.removeFromSuperview()
        
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        
        labelPlaceholder = UILabel(frame: CGRect(x:5, y:0, width:self.frame.size.width-5, height:self.frame.height))
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = self.font
        labelPlaceholder?.tag = 21
        
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        
    }
    
    func addErrorPlaceholderLabel() -> Void {
        
        self.endEditing(true)
        labelErrorPlaceholder?.removeFromSuperview()
        
        labelErrorPlaceholder = UILabel(frame: CGRect(x:5, y:0, width:self.frame.size.width-5, height:self.frame.height))
        labelErrorPlaceholder?.text = self.errorText
        labelErrorPlaceholder?.textAlignment = self.textAlignment
        labelErrorPlaceholder?.textColor = errorTextColor
        labelErrorPlaceholder?.font = UIFont(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        labelErrorPlaceholder?.tag = 21
        
        var frameError = labelErrorPlaceholder?.frame;
        frameError?.size.height = 15;
        frameError?.origin.y = self.bounds.size.height - (frameError?.size.height ?? 0)!;
        frameError?.origin.x = 0;
        
        labelErrorPlaceholder?.frame = frameError ?? CGRect.zero;
        
        if labelErrorPlaceholder != nil {
            self.addSubview(labelErrorPlaceholder!)
        }
        labelErrorPlaceholder?.isHidden = true;

    }
    
    func showErrorPlaceHolder() {
        
        labelErrorPlaceholder?.isHidden = false;
        
        var bottmLineFrame = bottomLineView?.frame ?? CGRect.zero;
        bottmLineFrame.origin.y = (labelErrorPlaceholder?.frame.origin.y ?? 0)! - 1;
        
        labelErrorPlaceholder?.alpha = 0;
        labelErrorPlaceholder?.frame = CGRect(x:(labelErrorPlaceholder?.frame.origin.x ?? 0)!, y:(labelErrorPlaceholder?.frame.origin.y ?? 0)!-5, width:labelErrorPlaceholder?.frame.size.width ?? 0, height:labelErrorPlaceholder?.frame.size.height ?? 0);
        
        var labelErrorFrame = labelErrorPlaceholder?.frame ?? CGRect.zero;
        labelErrorFrame.origin.y = labelErrorFrame.origin.y + 6;
        
        UIView.animate(withDuration: 0.2) {
            self.bottomLineView?.frame  =  bottmLineFrame;
            self.bottomLineView?.backgroundColor = self.errorLineColor;
            self.labelErrorPlaceholder?.alpha = 1;
            self.labelErrorPlaceholder?.frame = labelErrorFrame;
        }
        
        
    }
    
    func hideErrorPlaceHolder(){
        showingError = false;
        
        var labelErrorFrame = labelErrorPlaceholder?.frame;
        labelErrorFrame?.origin.y = (labelErrorFrame?.origin.y ?? 0)! - 6;
        
        UIView.animate(withDuration: 0.2) {
            self.labelErrorPlaceholder?.alpha = 0;
            self.labelErrorPlaceholder?.frame = labelErrorFrame!;
        }
        
    }

    // Checks The Default Placeholder Label
    func checkForDefaulLabel() -> Void {
        
        var aLabelView : UIView?
        
        for aView in self.subviews {
            
            if aView is UILabel {
                
                if aView.tag != 21 {
                    
                    aLabelView = aView
                }
            }
        }
        
        
        if self.text == nil || self.text == "" {
            aLabelView?.isHidden = true;
        }else{
            aLabelView?.isHidden = false;
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
        
        self.checkForDefaulLabel()
    }
    
    //MARK:- Upadate and Manage Subviews
    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;
        self.initialize()
    }
    
    //MARK:- Float UITextfield Placeholder Label.
    func floatPlaceHolder(selected:Bool) -> Void {
        
        
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = self.frame.height-2
        
        if disableFloatingLabel {
            labelPlaceholder?.isHidden = true
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            
            return
        }
        
        var labelFrame = labelPlaceholder?.frame
        labelFrame?.size.height = 12
        
        if selected {
            
            bottomLineView?.backgroundColor = selectedLineColor
            self.labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            
        } else {
            
            bottomLineView?.backgroundColor = lineColor;
            bottomLineFrame?.origin.y = self.frame.height-1
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.labelPlaceholder?.frame = labelFrame!;
            self.labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 12)
            self.bottomLineView?.frame  =  bottomLineFrame!;
        })
        
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = self.frame.height-1
        
        
        bottomLineView?.backgroundColor = lineColor;
        
        if disableFloatingLabel {
            labelPlaceholder?.isHidden = false
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            
            return
        }
        
        let labelFrame = CGRect(x:5, y:0, width:self.frame.size.width-5, height:self.frame.size.height)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.labelPlaceholder?.frame = labelFrame;
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            self.bottomLineView?.frame  =  bottomLineFrame!;
        })
        
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {
        if showingError {
            self.hideErrorPlaceHolder()
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }
}
