# TFDemoApp
It is Demo app for Textfield which has floating placeholder and Customisation features.


How To Use.

1) Add Textfield From Storyboard in View Controller and Set the class to ACFloatingTextField or create the textfield programmatically.

2) Set the Delegate.

3) Set Placeholder Text By Following Method.

E.g. — [_textField setTextFieldPlaceholderText:@"Username"];

4)Override the Textfield Delegate DidBeganEditing and DidEndEditing.

-(void)textFieldDidBeginEditing:(UITextField *)textField {

[(ACFloatingTextField *)textField textFieldDidBeginEditing];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
[(ACFloatingTextField *)textField textFieldDidEndEditing];
}

Customization

1) Change the colour of Bottom Line. 

_textField.btmLineColor = [UIColor blueColor];

2) Change the selected State colour for Bottom Line.

_textField.btmLineSelectionColor = [UIColor orangeColor];

3) Change the Placeholder Color.

_textField.placeHolderTextColor = [UIColor redColor];

4) Change the Selected Placeholder Color.

_textField.selectedPlaceHolderTextColor = [UIColor greenColor];

