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
    ACFloatingTextField *tf_, *tf_2;
}
@property (weak, nonatomic) IBOutlet ACFloatingTextField *textField;
@property (weak, nonatomic) IBOutlet UIStackView *containerForTexts;

@end

@implementation ViewController

- (IBAction)showErrorTap:(UIButton *)sender {

    [tf_ setErrorPlaceholder:@"You can not write do this pick that!"];
    [_textField setErrorPlaceholder:@"Haaa do you have a queue to put in progress!"];
    [tf_2 setErrorPlaceholder:@"No crejo in questo"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_textField setTextFieldPlaceholderText:@"Username"];
    _textField.selectedLineColor = [UIColor orangeColor];
    _textField.placeHolderColor = [UIColor redColor];
    _textField.selectedPlaceHolderColor = [UIColor greenColor];
    _textField.lineColor = [UIColor blueColor];
    
    
    tf_ = [[ACFloatingTextField alloc] init];
    [tf_ setTextFieldPlaceholderText:@"Placeholder"];
    [tf_ setText:@"Abhishek"];
    tf_.text = @"Chandani";
    [self.containerForTexts addArrangedSubview:tf_];
    
    
    tf_2 = [[ACFloatingTextField alloc] init];
    [tf_2 setTextFieldPlaceholderText:@"Placeholder"];
    [tf_2 setText:@"Abhishek"];

    [self.containerForTexts addArrangedSubview:tf_2];
    
}

#pragma mark  UITextfield Delegates

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
