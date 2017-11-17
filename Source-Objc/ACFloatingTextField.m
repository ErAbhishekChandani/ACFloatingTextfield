//
//  AppTextField.m
//  TFDemoApp
//
//  Created by Abhishek Chandani on 19/05/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//
#define kPlaceholderFontSize 12
#define kPlaceholderHeight 15

#import "ACFloatingTextField.h"
@interface ACFloatingTextField ()
{
    
    NSLayoutConstraint *bottomLineViewHeight;
    NSLayoutConstraint *placeholderLabelHeight;
    NSLayoutConstraint *errorLabelHieght;

}
@end
@implementation ACFloatingTextField

#pragma mark :- Drawing Methods
-(void)drawRect:(CGRect)rect {
    [self updateTextField:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect))];
}

#pragma mark :- Loading From NIB
-(void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

#pragma mark :- Initialization Methods
-(instancetype)init {
    if (self) {
        self = [super init];
        [self initialization];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        [self initialization];
    }
    return self;
}

#pragma mark :- Drawing Text Rect
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
}

#pragma mark  Override Set text
-(void)setText:(NSString *)text {
    [super setText:text];
    if (text) {
        [self floatTheLabel];
    }
    if (showingError) {
        [self hideErrorPlaceHolder];
    }
}

#pragma mark  Set Placeholder Text On Label
-(void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (![placeholder isEqualToString:@""]) {
        self.labelPlaceholder.text = placeholder;
    }
    
}

#pragma mark  Set Error Text On Label
-(void)setErrorText:(NSString *)errorText {
    _errorText = errorText;
    self.labelErrorPlaceholder.text = errorText;
}
-(void)setErrorTextColor:(UIColor *)errorTextColor {
    _errorTextColor = errorTextColor;
    self.labelErrorPlaceholder.textColor = _errorTextColor;
}
-(void)setErrorLineColor:(UIColor *)errorLineColor {
    _errorLineColor = errorLineColor;
    [self floatTheLabel];
}
-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self floatTheLabel];
}

-(void)setSelectedLineColor:(UIColor *)selectedLineColor {
    _selectedLineColor = selectedLineColor;
    [self floatTheLabel];
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self floatTheLabel];
}

-(void)setSelectedPlaceHolderColor:(UIColor *)selectedPlaceHolderColor {
    _selectedPlaceHolderColor = selectedPlaceHolderColor;
    [self floatTheLabel];
}


#pragma mark  Intialization method
-(void)initialization{
    
    self.clipsToBounds = true;
    
    //VARIABLE INITIALIZATIONS
    
    //1. Placeholder Color.
    if (_placeHolderColor == nil){
        _placeHolderColor = [UIColor lightGrayColor];
    }
    
    //2. Placeholder Color When Selected.
    if (_selectedPlaceHolderColor==nil) {
        _selectedPlaceHolderColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    //3. Bottom line Color.
    if (_lineColor==nil) {
        _lineColor = [UIColor blackColor];
    }
    
    //4. Bottom line Color When Selected.
    if (_selectedLineColor==nil) {
        _selectedLineColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    //5. Bottom line error Color.
    if (_errorLineColor==nil) {
        _errorLineColor = [UIColor redColor];
    }
    
    //6. Bottom place Color When show error.
    if (_errorTextColor==nil) {
        _errorTextColor = [UIColor redColor];
    }
    
    /// Adding Bottom Line View.
    [self addBottomLineView];
    
    /// Adding Placeholder Label.
    [self addPlaceholderLabel];
    
    [self addErrorPlaceholderLabel];

    [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];

    /// Placeholder Label Configuration.
    if (![self.text isEqualToString:@""]){
        [self floatTheLabel];
    }
    
}

#pragma mark :- Private Methods
-(void)addBottomLineView{
    
    if (bottomLineView.superview != nil) {
        return;
    }
    bottomLineView = [UIView new];
    bottomLineView.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
    bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bottomLineView];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint * bottomConstraint = [NSLayoutConstraint constraintWithItem:bottomLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    bottomLineViewHeight = [NSLayoutConstraint constraintWithItem:bottomLineView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute: NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:1];

    [self addConstraints:@[leadingConstraint,trailingConstraint,bottomConstraint]];
    [bottomLineView addConstraint:bottomLineViewHeight];
    
    [self addTarget:self action:@selector(textfieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
}
-(void)textfieldEditingChanged {
    if (showingError) {
        [self hideError];
    }
}
-(void)addPlaceholderLabel{

    if (self.labelPlaceholder.superview != nil){
        return;
    }

    _labelPlaceholder = [UILabel new];
    _labelPlaceholder.text = self.placeholder;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = _placeHolderColor;
    _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:kPlaceholderFontSize];
    _labelPlaceholder.hidden = YES;
    [_labelPlaceholder sizeToFit];
    _labelPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:_labelPlaceholder];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_labelPlaceholder attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:_labelPlaceholder attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_labelPlaceholder attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5];
    placeholderLabelHeight = [NSLayoutConstraint constraintWithItem:_labelPlaceholder
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:kPlaceholderHeight];

    [self addConstraints:@[topConstraint,trailingConstraint,leadingConstraint]];
    [_labelPlaceholder addConstraint:placeholderLabelHeight];
}

#pragma mark  Adding Error Label in textfield.
-(void)addErrorPlaceholderLabel{
    
    if (self.labelErrorPlaceholder.superview != nil){
        return;
    }

    self.labelErrorPlaceholder = [[UILabel alloc] init];
    self.labelErrorPlaceholder.text = self.errorText;
    self.labelErrorPlaceholder.textAlignment = self.textAlignment;
    self.labelErrorPlaceholder.textColor = self.errorTextColor;
    self.labelErrorPlaceholder.font = [UIFont fontWithName:self.font.fontName size:kPlaceholderFontSize];
    [self.labelErrorPlaceholder sizeToFit];
    self.labelErrorPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.labelErrorPlaceholder];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.labelErrorPlaceholder attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.labelErrorPlaceholder attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    errorLabelHieght = [NSLayoutConstraint constraintWithItem:self.labelErrorPlaceholder
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute: NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:0];

    [self addConstraints:@[topConstraint,trailingConstraint]];
    [self.labelErrorPlaceholder addConstraint:errorLabelHieght];

}

#pragma mark  Method to show Error Label.
-(void)showErrorPlaceHolder{
    
    bottomLineViewHeight.constant = 2;
    if (self.errorText != nil && ![self.errorText isEqualToString:@""]) {
        errorLabelHieght.constant = kPlaceholderHeight;
        [UIView animateWithDuration:0.2 animations:^{
            bottomLineView.backgroundColor = _errorLineColor;
            [self layoutIfNeeded];
        }];

    }else{
        errorLabelHieght.constant = 0;
        [UIView animateWithDuration:0.2 animations:^{
            bottomLineView.backgroundColor = _errorLineColor;
            [self layoutIfNeeded];
        }];

    }
    if (!self.disableShakeWithError) {
        [self shakeView:bottomLineView];
    }
}

#pragma mark  Method to Hide Error Label.
-(void)hideErrorPlaceHolder{
    showingError = NO;
    
    if (self.errorText == nil || [self.errorText isEqualToString:@""]) {
        return;
    }
    
    errorLabelHieght.constant = 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark  Update and Manage Subviews
-(void)updateTextField:(CGRect )frame {
    
    self.frame = frame;
    [self initialization];
}

#pragma mark  Float UITextfield Placeholder Label.
-(void)floatPlaceHolder:(BOOL)selected {
    
    self.labelPlaceholder.hidden = NO;

    if (selected) {
        bottomLineView.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
        self.labelPlaceholder.textColor = self.selectedPlaceHolderColor;
        bottomLineViewHeight.constant = 2;
        [self setValue:self.selectedPlaceHolderColor forKeyPath:@"_placeholderLabel.textColor"];

    }
    else{
        
        bottomLineView.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
        self.labelPlaceholder.textColor = self.placeHolderColor;
        bottomLineViewHeight.constant = 1;
        [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    if (self.disableFloatingLabel){
        
        _labelPlaceholder.hidden = YES;
//        [UIView animateWithDuration:0.2 animations:^{
//            [self layoutIfNeeded];
//        }];
        
        return;
    }
    
    // If already floated
    if (placeholderLabelHeight.constant == kPlaceholderHeight) {
        return;
    }
    
    
    placeholderLabelHeight.constant = kPlaceholderHeight;
    _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:kPlaceholderFontSize];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
}
-(void)resignPlaceholder{

    [self setValue:self.placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];

    bottomLineView.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
    bottomLineViewHeight.constant = 1;

    if (self.disableFloatingLabel){
        
        self.labelPlaceholder.hidden = YES;
        self.labelPlaceholder.textColor = self.placeHolderColor;
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        
        return;
    }
    
    
    CGFloat height = CGRectGetHeight(self.frame);
    placeholderLabelHeight.constant = height;
    
    [UIView animateWithDuration:0.3 animations:^{
        _labelPlaceholder.font = self.font;
        _labelPlaceholder.textColor = _placeHolderColor;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.labelPlaceholder.hidden = YES;
        self.placeholder = self.labelPlaceholder.text;
    }];

}
#pragma mark  UITextField Begin Editing.

-(void)textFieldDidBeginEditing {
    if (showingError) {
        [self hideErrorPlaceHolder];
    }
    if (!self.disableFloatingLabel) {
        self.placeholder = @"";
    }

    [self floatTheLabel];
    [self layoutSubviews];
}

#pragma mark  UITextField End Editing.
-(void)textFieldDidEndEditing {
    
    [self floatTheLabel];
    
}

#pragma mark  Float & Resign

-(void)floatTheLabel{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.text isEqualToString:@""] && self.isFirstResponder) {
            
            [self floatPlaceHolder:YES];
            
        }else if ([self.text isEqualToString:@""] && !self.isFirstResponder) {
            
            [self resignPlaceholder];
            
        }else if (![self.text isEqualToString:@""] && !self.isFirstResponder) {
            
            [self floatPlaceHolder:NO];
            
        }else if (![self.text isEqualToString:@""] && self.isFirstResponder) {
            
            [self floatPlaceHolder:YES];
        }
    });
    
}
#pragma mark  Shake Animation
-(void)shakeView:(UIView*)view{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[@(-20.0), @20.0, @(-20.0), @20.0, @(-10.0), @10.0, @(-5.0), @(5.0), @(0.0) ];
    [view.layer addAnimation:animation forKey:@"shake"];

}
#pragma mark  Set Placeholder Text On Error Labels
-(void)showError {
    showingError = YES;
    [self showErrorPlaceHolder];
}
-(void)hideError {
    showingError = false;
    [self hideErrorPlaceHolder];
    [self floatTheLabel];
}
-(void)showErrorWithText:(NSString *)errorText {
    _errorText = errorText;
    _labelErrorPlaceholder.text = errorText;
    showingError = YES;
    [self showErrorPlaceHolder];
}

#pragma mark  UITextField Responder Overide
-(BOOL)becomeFirstResponder {

    BOOL result = [super becomeFirstResponder];
    [self textFieldDidBeginEditing];
    return result;
}

-(BOOL)resignFirstResponder {

    BOOL result = [super resignFirstResponder];
    [self textFieldDidEndEditing];
    return result;
}

@end
