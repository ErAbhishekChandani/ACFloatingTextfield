//
//  ACFloatingTextfield.swift
//  ACFloatingTextField
//
//  Created by Macintosh on 31/07/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class ACFloatingTextfield: UITextField {

     private var bottomLineView : UIView?
     private var labelPlaceholder : UILabel?
    
     @IBInspectable  var disableFloatingLabel : Bool = false
    
     @IBInspectable  var lineColor : UIColor = UIColor.blackColor()
    
     @IBInspectable  var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
     @IBInspectable  var placeHolderColor : UIColor = UIColor.lightGrayColor()
    
     @IBInspectable  var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
    
    
    //MARK:- Set Text
    override var text:String?  {
        didSet {
            floatTheLabel()
            checkForDefaulLabel()
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        self.upadteTextField(CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect)));

    }

    // MARK:- Loading From NIB
    override func awakeFromNib() {
        
        super.awakeFromNib()
         self.initialize()
    }
    
    // MARK:- Intialization
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.initialize()
    
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }

    // MARK:- Text Rect Management
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
    }

    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        
        /// HIDE DEFAULT PLACEHOLDER LABEL OF UITEXTFIELD
        checkForDefaulLabel()
        
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
    private func addBottomLine(){
    
        bottomLineView?.removeFromSuperview()

        //Bottom Line UIView Configuration.
        bottomLineView = UIView(frame: CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 2))
        bottomLineView?.backgroundColor = lineColor;
        bottomLineView?.tag = 20;
        
        if bottomLineView != nil {
            self.addSubview(bottomLineView!)
        }

    }
    
    //MARK:- ADD Floating Label
    private func addFloatingLabel(){
    
        labelPlaceholder?.removeFromSuperview()

        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        
        labelPlaceholder = UILabel(frame: CGRectMake(5, 0, self.frame.size.width-5, CGRectGetHeight(self.frame)))
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = self.font
        labelPlaceholder?.tag = 21
        
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }

    }
    
    // Checks The Default Placeholder Label
   private func checkForDefaulLabel() -> Void {
        
        var aLabelView : UIView?
        
        for aView in self.subviews {
            
            if aView.isKindOfClass(UILabel) {
                
                if aView.tag != 21 {
                    
                    aLabelView = aView
                }
            }
        }
        
        
        if self.text == nil || self.text == "" {
            aLabelView?.hidden = true;
        }else{
            aLabelView?.hidden = false;
        }
        
    }

    //MARK:- Float & Resign
   private func floatTheLabel() -> Void {
        
        if self.text == "" && self.isFirstResponder() {
            
            floatPlaceHolder(true)
            
        }else if self.text == "" && !self.isFirstResponder() {
            
            resignPlaceholder()
            
        }else if self.text != "" && !self.isFirstResponder()  {
            
            floatPlaceHolder(false)
            
        }else if self.text != "" && self.isFirstResponder() {
            
            floatPlaceHolder(true)
        }
        
       self.checkForDefaulLabel()
    }
    
    //MARK:- Upadate and Manage Subviews
   private func upadteTextField(frame:CGRect) -> Void {
         self.frame = frame;
         self.initialize()
    }

    //MARK:- Float UITextfield Placeholder Label.
   private func floatPlaceHolder(selected:Bool) -> Void {

        
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = CGRectGetHeight(self.frame)-2
        
        if disableFloatingLabel {
            labelPlaceholder?.hidden = true
            UIView.animateWithDuration(0.2, animations: {
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
            bottomLineFrame?.origin.y = CGRectGetHeight(self.frame)-1
            self.labelPlaceholder?.textColor = self.placeHolderColor;

        }
        
        UIView.animateWithDuration(0.2, animations: {
            
            self.labelPlaceholder?.frame = labelFrame!;
            self.labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 12)
            self.bottomLineView?.frame  =  bottomLineFrame!;
        })

  
    }
    
    //MARK:- Resign the Placeholder
    private func resignPlaceholder() -> Void {
        
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = CGRectGetHeight(self.frame)-1

        
        bottomLineView?.backgroundColor = lineColor;
        
        if disableFloatingLabel {
            labelPlaceholder?.hidden = false
            self.labelPlaceholder?.textColor = self.placeHolderColor;

            UIView.animateWithDuration(0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            
            return
        }
        
        let labelFrame = CGRectMake(5, 0, self.frame.size.width-5, self.frame.size.height)
        
        UIView.animateWithDuration(0.2, animations: {
            self.labelPlaceholder?.frame = labelFrame;
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            self.bottomLineView?.frame  =  bottomLineFrame!;
        })

    }
    
    //MARK:- UITextField Begin Editing.
    private func textFieldDidBeginEditing() -> Void {
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    private func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }

    //MARK:- UITextfield Becomes First Responder
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }


}
