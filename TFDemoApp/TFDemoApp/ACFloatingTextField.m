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
    return CGRectMake(4, 5, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 5, bounds.size.width, bounds.size.height);
}

-(void)initialization{
    
    
    [bottomLineView removeFromSuperview];
    [_labelPlaceholder removeFromSuperview];
    
    NSString *placeHolderText = _labelPlaceholder.text;
    
    bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 2)];
    if (_btmLineColor==nil) {
        _btmLineColor = [UIColor blackColor];
    }
    bottomLineView.backgroundColor = _btmLineColor;
    bottomLineView.tag = 20;
    
    if (bottomLineView.superview == nil) {
        [self addSubview:bottomLineView];
    }
    
    
    _labelPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-5, self.frame.size.height)];
    if (_placeHolderTextColor == nil){
        _placeHolderTextColor = [UIColor lightGrayColor];
    }
    
    _labelPlaceholder.text = placeHolderText;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = _placeHolderTextColor;
    _labelPlaceholder.font = [UIFont fontWithName:@"helvetica" size:16.0];
    _labelPlaceholder.tag = 21;
    
    
    if (_labelPlaceholder.superview == nil) {
        
        [self addSubview:_labelPlaceholder];

    }
    

}

#pragma mark  Upadate and Manage Subviews

-(void)upadteTextField:(CGRect )frame {

    self.frame = frame;
    [self initialization];
}

-(void)textFieldDidBeginEditing {


    if ([self.text isEqualToString:@""]){
        
        if (_btmLineSelectionColor==nil) {
            _btmLineSelectionColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
        }
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
            _labelPlaceholder.font = [UIFont fontWithName:@"helvetica" size:12.0];
            if (_selectedPlaceHolderTextColor==nil) {
                _selectedPlaceHolderTextColor = [UIColor colorWithRed:19/256.0 green:141/256.0 blue:117/256.0 alpha:1.0];
            }
            _labelPlaceholder.textColor = _selectedPlaceHolderTextColor;
            bottomLineView.frame  =  bottmLineFrame;

        }];

    }
    
}
-(void)textFieldDidEndEditing {

        if ([self.text isEqualToString:@""]){
        
        if (_btmLineColor==nil) {
            _btmLineColor = [UIColor blackColor];
        }
        bottomLineView.backgroundColor = _btmLineColor;

        if (self.disableFloatingLabel){
            
            _labelPlaceholder.hidden = NO;
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
            _labelPlaceholder.font = [UIFont fontWithName:@"helvetica" size:16.0];
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
-(void)setTextFieldPlaceholderText:(NSString *)placeholderText {

    self.labelPlaceholder.text = placeholderText;
}
@end
