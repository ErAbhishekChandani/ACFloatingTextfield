//
//  AppTextField.m
//  TFDemoApp
//
//  Created by Abhishek Chandani on 19/05/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

#import "ACFloatingTextField.h"

@implementation ACFloatingTextField


#pragma mark  Initialization Methods

-(void)drawRect:(CGRect)rect {
    
    [self upadteTextField:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect))];
    
}

-(void)awakeFromNib {
    
    [self initialization];
    
}

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

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 4, bounds.size.width, bounds.size.height);
}

-(void)setText:(NSString *)text {
    
    [super setText:text];
    if (text) {
        
        [self floatPlaceHolder];
        
    }
    [self checkForDefaulLabel];
}
-(void)initialization{
    
    //HIDE DEFAULT PLACEHOLDER LABEL OF UITEXTFIELD
    
    [self checkForDefaulLabel];
    
    //VARIABLE INITIALIZATIONS
    
    //1. Placeholder Color.
    if (_placeHolderTextColor == nil){
        _placeHolderTextColor = [UIColor lightGrayColor];
    }
    
    //2. Placeholder Color When Selected.
    if (_selectedPlaceHolderTextColor==nil) {
        _selectedPlaceHolderTextColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    //3. Bottom line Color.
    if (_btmLineColor==nil) {
        _btmLineColor = [UIColor blackColor];
    }
    
    //4. Bottom line Color When Selected.
    if (_btmLineSelectionColor==nil) {
        _btmLineSelectionColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
    }
    
    [bottomLineView removeFromSuperview];
    [_labelPlaceholder removeFromSuperview];
    
    if (![self.placeholder isEqualToString:@""]&&self.placeholder!=nil) {
        _labelPlaceholder.text = self.placeholder;
    }
    
    NSString *placeHolderText = _labelPlaceholder.text;
    
    bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 2)];
    bottomLineView.backgroundColor = _btmLineColor;
    bottomLineView.tag = 20;
    [self addSubview:bottomLineView];
    
    //Placeholder Label Configuration.
    _labelPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-5, CGRectGetHeight(self.frame))];
    _labelPlaceholder.text = placeHolderText;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = _placeHolderTextColor;
    _labelPlaceholder.font = self.font;;
    _labelPlaceholder.tag = 21;
    [self addSubview:_labelPlaceholder];
    
    if (![self.text isEqualToString:@""]) {
        
        [self floatPlaceHolder];
    }
    
}
-(void)checkForDefaulLabel{
    
    if ([self.text isEqualToString:@""]) {
        
        for (UIView *view in self.subviews) {
            
            if ([view isKindOfClass:[UILabel class]]) {
                
                UILabel *newLabel = (UILabel *)view;
                if (newLabel.tag!=21) {
                    newLabel.hidden = YES;
                }
            }
        }
        
    }else{
        
        for (UIView *view in self.subviews) {
            
            if ([view isKindOfClass:[UILabel class]]) {
                
                UILabel *newLabel = (UILabel *)view;
                if (newLabel.tag!=21) {
                    newLabel.hidden = NO;
                }
            }
        }
        
    }
    
}

#pragma mark  Upadate and Manage Subviews

-(void)upadteTextField:(CGRect )frame {
    
    self.frame = frame;
    [self initialization];
}

#pragma mark  Float UITextfield Placeholder Label.
-(void)floatPlaceHolder {
    
    if ([self.text isEqualToString:@""]||self.isFirstResponder) {
        
        bottomLineView.backgroundColor = _btmLineSelectionColor;
        
        if (self.disableFloatingLabel){
            
            _labelPlaceholder.hidden = YES;
            CGRect bottmLineFrame = bottomLineView.frame;
            bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-2;
            [UIView animateWithDuration:0.2 animations:^{
                bottomLineView.frame  =  bottmLineFrame;
            }];
            
            return;
            
        }
        
        CGRect frame = _labelPlaceholder.frame;
        frame.size.height = 12;
        CGRect bottmLineFrame = bottomLineView.frame;
        bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-2;
        [UIView animateWithDuration:0.2 animations:^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:12];
            _labelPlaceholder.textColor = _selectedPlaceHolderTextColor;
            bottomLineView.frame  =  bottmLineFrame;
            
        }];
        
    }
    else{
        
        bottomLineView.backgroundColor = _btmLineColor;
        
        if (self.disableFloatingLabel){
            
            _labelPlaceholder.hidden = YES;
            CGRect bottmLineFrame = bottomLineView.frame;
            bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-2;
            [UIView animateWithDuration:0.2 animations:^{
                bottomLineView.frame  =  bottmLineFrame;
            }];
            
            return;
            
        }
        
        CGRect frame = _labelPlaceholder.frame;
        frame.size.height = 12;
        CGRect bottmLineFrame = bottomLineView.frame;
        bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
        [UIView animateWithDuration:0.2 animations:^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = [UIFont fontWithName:self.font.fontName size:12];
            _labelPlaceholder.textColor = _placeHolderTextColor;
            bottomLineView.frame  =  bottmLineFrame;
            
        }];
        
        
    }
    
}

#pragma mark  UITextField Begin Editing.

-(void)textFieldDidBeginEditing {
    
    [self floatPlaceHolder];
    [self layoutSubviews];
    
}


#pragma mark  UITextField End Editing.
-(void)textFieldDidEndEditing {
    
    if ([self.text isEqualToString:@""]){
        
        bottomLineView.backgroundColor = _btmLineColor;
        
        if (self.disableFloatingLabel){
            
            _labelPlaceholder.hidden = NO;
            _labelPlaceholder.textColor = _placeHolderTextColor;
            CGRect bottmLineFrame = bottomLineView.frame;
            bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
            [UIView animateWithDuration:0.2 animations:^{
                bottomLineView.frame  =  bottmLineFrame;
            }];
            
            return;
            
        }
        
        
        CGRect frame = CGRectMake(5, 0, self.frame.size.width-5, self.frame.size.height);
        CGRect bottmLineFrame = bottomLineView.frame;
        bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
        [UIView animateWithDuration:0.2 animations:^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = self.font;
            _labelPlaceholder.textColor = _placeHolderTextColor;
            bottomLineView.frame  =  bottmLineFrame;
        }];
        
    }else{
        
        if (_btmLineColor==nil) {
            _btmLineColor = [UIColor blackColor];
        }
        bottomLineView.backgroundColor = _btmLineColor;
        _labelPlaceholder.textColor = _placeHolderTextColor;
        
        CGRect bottmLineFrame = bottomLineView.frame;
        bottmLineFrame.origin.y = CGRectGetHeight(self.frame)-1;
        [UIView animateWithDuration:0.2 animations:^{
            bottomLineView.frame  =  bottmLineFrame;
        }];
        
    }
    
}

#pragma mark  Set Placeholder Text On Labels
-(void)setTextFieldPlaceholderText:(NSString *)placeholderText {
    
    self.labelPlaceholder.text = placeholderText;
    [self textFieldDidEndEditing];
}
-(void)setPlaceholder:(NSString *)placeholder {
    
    self.labelPlaceholder.text = placeholder;
    [self textFieldDidEndEditing];
    
}

@end
