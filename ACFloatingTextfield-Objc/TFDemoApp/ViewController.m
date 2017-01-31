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
    _textField.selectedLineColor = [UIColor orangeColor];
    _textField.placeHolderColor = [UIColor redColor];
    _textField.selectedPlaceHolderColor = [UIColor greenColor];
    _textField.lineColor = [UIColor blueColor];
    
    
    tf_ = [[ACFloatingTextField alloc]initWithFrame:CGRectMake(20, 300, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 45)];
    
    [tf_ setTextFieldPlaceholderText:@"Placeholder"];
    [tf_ setText:@"Abhishek"];
    tf_.text = @"Chandani";
    [self.view addSubview:tf_];
    
}

#pragma mark  UITextfield Delegates

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
