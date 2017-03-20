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

@property(nonatomic, strong)   NSString  *errorPlaceholder;

@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,strong) UIColor *placeHolderColor;
@property (nonatomic,strong) UIColor *selectedPlaceHolderColor;
@property (nonatomic,strong) UIColor *selectedLineColor;
@property (nonatomic,strong) UIColor *errorPlaceHolderColor;
@property (nonatomic,strong) UIColor *errorLineColor;

@property (nonatomic,strong) UILabel *labelPlaceholder;
@property (nonatomic,strong) UILabel *labelErrorPlaceholder;

@property (assign) BOOL disableFloatingLabel;
@property (assign) BOOL disableFloatingErrorLabel;

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(void)setTextFieldPlaceholderText:(NSString *)placeholderText;
-(void)setTextFieldErrorPlaceholderText:(NSString *)errorPlaceholderText;
-(void)updateTextField:(CGRect)frame;


@end
