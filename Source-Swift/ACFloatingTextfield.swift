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
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    fileprivate var errorLabelHieght : NSLayoutConstraint?
    
    private var _isRightViewVisible: Bool = true
    
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var ImgWidth: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var ImgHeight: CGFloat = 20 {
        didSet {
            updateView()
        }
    }
    
    /// Disable Floating Label when true.
    @IBInspectable open var disableFloatingLabel : Bool = false
    
    /// Shake Bottom line when Showing Error ?
    @IBInspectable open var shakeLineWithError : Bool = true
    
    /// Change Bottom Line Color.
    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change line color when Editing in textfield
    @IBInspectable open var selectedLineColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0){
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color.
    @IBInspectable open var placeHolderColor : UIColor = UIColor.lightGray {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color while editing.
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor(red: 19/256.0, green: 141/256.0, blue: 117/256.0, alpha: 1.0){
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change Error Text color.
    @IBInspectable open var errorTextColor : UIColor = UIColor.red{
        didSet{
            self.labelErrorPlaceholder?.textColor = errorTextColor
            self.floatTheLabel()
        }
    }
    
    /// Change Error Line color.
    @IBInspectable open var errorLineColor : UIColor = UIColor.red{
        didSet{
            self.floatTheLabel()
        }
    }
    
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
    /* override open func textRect(forBounds bounds: CGRect) -> CGRect {
     return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
     }
     
     override open func editingRect(forBounds bounds: CGRect) -> CGRect {
     return CGRect(x:4, y:4, width:bounds.size.width, height:bounds.size.height);
     } */
    
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
        self.labelErrorPlaceholder?.text = self.errorText
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
        
        /// Error Placeholder Label Configuration.
        addErrorPlaceholderLabel()
        /// Checking Floatibility
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine(){
        if bottomLineView?.superview != nil {
            return
        }
        //Bottom Line UIView Configuration.
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        
        self.addConstraints([leadingConstraint,trailingConstraint,bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight!)
        
        self.addTarget(self, action: #selector(self.textfieldEditingChanged), for: .editingChanged)
    }
    
    @objc func textfieldEditingChanged(){
        if showingError {
            hideError()
        }
    }
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){
        if labelPlaceholder?.superview != nil {
            return
        }
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = UIFont.init(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        let leadingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 5)
        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15)
        
        self.addConstraints([leadingConstraint,trailingConstraint,topConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
    }
    
    
    func addErrorPlaceholderLabel() -> Void {
        if self.labelErrorPlaceholder?.superview != nil{
            return
        }
        labelErrorPlaceholder = UILabel()
        labelErrorPlaceholder?.text = self.errorText
        labelErrorPlaceholder?.textAlignment = self.textAlignment
        labelErrorPlaceholder?.textColor = errorTextColor
        labelErrorPlaceholder?.font = UIFont(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        labelErrorPlaceholder?.sizeToFit()
        labelErrorPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelErrorPlaceholder!)

        let trailingConstraint = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        errorLabelHieght = NSLayoutConstraint.init(item: labelErrorPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)

        self.addConstraints([trailingConstraint,topConstraint])
        labelErrorPlaceholder?.addConstraint(errorLabelHieght!)
    }
    
    func showErrorPlaceHolder() {
        bottomLineViewHeight?.constant = 2;
        
        if self.errorText != nil && self.errorText != "" {
            errorLabelHieght?.constant = 15;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
            }, completion: nil)
        }else{
            errorLabelHieght?.constant = 0;
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.bottomLineView?.backgroundColor = self.errorLineColor;
                self.layoutIfNeeded()
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
        
        errorLabelHieght?.constant = 0;
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }

    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        DispatchQueue.main.async {
            if self.text == "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }else if self.text == "" && !self.isFirstResponder {
                self.resignPlaceholder()
            }else if self.text != "" && !self.isFirstResponder  {
                self.floatPlaceHolder(selected: false)
            }else if self.text != "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }
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
        if selected {
            
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
            bottomLineViewHeight?.constant = 2;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: selectedPlaceHolderColor])
        } else {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
            bottomLineViewHeight?.constant = 1;
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        }

        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }
        
        if placeholderLabelHeight?.constant == 15 {
            return
        }

        placeholderLabelHeight?.constant = 15;
        labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: 12)

        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])

        bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
        bottomLineViewHeight?.constant = 1;

        if disableFloatingLabel {
            
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            return
        }
        
        placeholderLabelHeight?.constant = self.frame.height

        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.layoutIfNeeded()
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
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension ACFloatingTextfield{
    func updateView() {
        setLeftImage()
        setRightImage()
        
    }
    func setLeftImage() {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: ImgWidth, height: ImgHeight))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: ImgHeight))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: ImgHeight))
        }
        
        leftView = view
    }
    
    func setRightImage() {
        rightViewMode = UITextField.ViewMode.always
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ImgWidth , height: ImgHeight))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: ImgHeight))
            view.addSubview(imageView)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: ImgHeight))
        }
        
        rightView = view
    }
}
