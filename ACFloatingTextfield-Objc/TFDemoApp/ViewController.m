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

    _textFieldPassword.text = @"They Said";
    _textFieldUsername.text = nil;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_textFieldUsername setPlaceholder:@"Section"];
    _textFieldUsername.selectedLineColor = [UIColor redColor];
    _textFieldUsername.placeHolderColor = [UIColor grayColor];
    _textFieldUsername.selectedPlaceHolderColor = [UIColor redColor];
    _textFieldUsername.lineColor = [UIColor grayColor];
    _textFieldUsername.textColor = [UIColor grayColor];
    UIFont *font = [UIFont fontWithName:@"Calibri" size:15];
    [_textFieldUsername setFont:font];
    
    _textFieldPassword.selectedLineColor = [UIColor redColor];
    _textFieldPassword.placeHolderColor = [UIColor grayColor];
    _textFieldPassword.selectedPlaceHolderColor = [UIColor redColor];
    _textFieldPassword.lineColor = [UIColor grayColor];
    _textFieldPassword.textColor = [UIColor grayColor];

    _textFieldUsername.text = @"FEGBHE gebe gehbge";
    _textFieldPassword.text = @"FEGBHE gebe gehbge";


}

- (IBAction)back:(UIStoryboardSegue *)sender {
    
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
