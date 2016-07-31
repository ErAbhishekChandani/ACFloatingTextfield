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
{

    ACFloatingTextField *tf_;
}
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_textField setTextFieldPlaceholderText:@"Username"];
    _textField.btmLineSelectionColor = [UIColor orangeColor];
    _textField.placeHolderTextColor = [UIColor redColor];
    _textField.selectedPlaceHolderTextColor = [UIColor greenColor];
    _textField.btmLineColor = [UIColor blueColor];
    
    
    tf_ = [[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, 300, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    tf_.delegate = self;
    
    [tf_ setTextFieldPlaceholderText:@"Placeholder"];

    [self.view addSubview:tf_];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {

    [(ACFloatingTextField *)textField textFieldDidBeginEditing];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [(ACFloatingTextField *)textField textFieldDidEndEditing];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
