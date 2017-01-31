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
    
     @IBInspectable  var lineColor : UIColor = UIColor.black
    
     @IBInspectable  var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
     @IBInspectable  var placeHolderColor : UIColor = UIColor.lightGray
    
     @IBInspectable  var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0)
    
    
    
    //MARK:- Set Text
    override var text:String?  {
        didSet {
            floatTheLabel()
            checkForDefaulLabel()
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));

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
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
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
        bottomLineView = UIView(frame: CGRect(x:0, y:self.frame.height-1, width:self.frame.width, height:2))
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
    
    // Checks The Default Placeholder Label
   private func checkForDefaulLabel() -> Void {
        
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
   private func floatTheLabel() -> Void {
        
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
   private func upadteTextField(frame:CGRect) -> Void {
         self.frame = frame;
         self.initialize()
    }

    //MARK:- Float UITextfield Placeholder Label.
   private func floatPlaceHolder(selected:Bool) -> Void {

        
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
    private func resignPlaceholder() -> Void {
        
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
