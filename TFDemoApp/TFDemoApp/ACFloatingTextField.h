//
//  AppTextField.h
//  TFDemoApp
//
//  Created by Abhishek Chandani on 19/05/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACFloatingTextField : UITextField
{
    UIView *bottomLineView;
}

@property (nonatomic,strong) UIColor *btmLineColor;
@property (nonatomic,strong) UIColor *placeHolderTextColor;
@property (nonatomic,strong) UIColor *selectedPlaceHolderTextColor;
@property (nonatomic,strong) UIColor *btmLineSelectionColor;

@property (nonatomic,strong) UILabel *labelPlaceholder;

@property (assign) BOOL disableFloatingLabel;

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)textFieldDidBeginEditing;
-(void)textFieldDidEndEditing;
-(void)setTextFieldPlaceholderText:(NSString *)placeholderText;
-(void)upadteTextField:(CGRect)frame;

@end
