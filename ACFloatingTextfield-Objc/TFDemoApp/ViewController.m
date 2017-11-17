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
    [_textFieldPassword showErrorWithText:@"Password should not less then 6 characters."];
    [_textFieldUsername showError];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_textFieldPassword becomeFirstResponder];

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
