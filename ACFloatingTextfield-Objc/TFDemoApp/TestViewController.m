//
//  TestViewController.m
//  ACFloatingTextField
//
//  Created by mac on 12/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

#import "TestViewController.h"
#import "ACFloatingTextField.h"
@interface TestViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textFieldUserName;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    ACFloatingTextField *newTextField = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(20, 300, 300, 50)];
    newTextField.delegate = self;
    newTextField.placeholder = @"Password";
    newTextField.lineColor = [UIColor yellowColor];
    newTextField.placeHolderColor = [UIColor blueColor];
    newTextField.selectedLineColor = [UIColor orangeColor];
    newTextField.selectedPlaceHolderColor = [UIColor orangeColor];
    [self.view addSubview:newTextField];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
- (IBAction)showError:(id)sender {
    [_textFieldUserName showErrorWithText:@"this is error"];
}
- (IBAction)hideError:(id)sender {
    [_textFieldUserName hideError];
}
- (IBAction)changeLineColor:(id)sender {
    _textFieldUserName.lineColor = [UIColor yellowColor];
}
- (IBAction)changePlaceHolderColor:(id)sender {
    _textFieldUserName.placeHolderColor = [UIColor yellowColor];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
