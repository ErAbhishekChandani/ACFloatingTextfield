//
//  ViewController.m
//  TFDemoApp
//
//  Created by Abhishek on 30/06/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

#import "ViewController.h"
#import "ACFloatingTextField.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldPassword;

@end

@implementation ViewController

- (IBAction)showErrorTap:(UIButton *)sender {

    [_textFieldPassword showErrorWithText:@"This is Va Error"];
    [_textFieldUsername showErrorWithText:@"Password should not less then 6 characters."];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldUsername.backgroundColor = [UIColor clearColor];
    _textFieldPassword.backgroundColor = [UIColor clearColor];
    _textFieldUsername.textColor = [UIColor whiteColor];
    _textFieldPassword.textColor = [UIColor whiteColor];
    
    _textFieldUsername.selectedLineColor = [UIColor yellowColor];
    _textFieldUsername.selectedPlaceHolderColor = [UIColor yellowColor];
    _textFieldUsername.placeHolderColor = [UIColor whiteColor];
    _textFieldUsername.lineColor = [UIColor whiteColor];

    _textFieldPassword.selectedLineColor = [UIColor yellowColor];
    _textFieldPassword.selectedPlaceHolderColor = [UIColor yellowColor];
    _textFieldPassword.placeHolderColor = [UIColor whiteColor];
    _textFieldPassword.lineColor = [UIColor whiteColor];
    
}

#pragma mark  UITextfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
