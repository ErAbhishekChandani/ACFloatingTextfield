# ACFloatingTextField

![ACFloatingTextfield](https://github.com/ErAbhishekChandani/ACFloatingTextfield/blob/master/ACFloatingField.png "ACFloatingTextfield")

[![Version](https://img.shields.io/cocoapods/v/ACFloatingTextfield-Objc.svg?style=flat)](https://cocoapods.org/pods/ACFloatingTextfield-Objc)
[![License](https://img.shields.io/cocoapods/l/ACFloatingTextfield-Objc.svg?style=flat)](https://cocoapods.org/pods/ACFloatingTextfield-Objc)
[![Platform](https://img.shields.io/cocoapods/p/ACFloatingTextfield-Objc.svg?style=flat)](https://cocoapods.org/pods/ACFloatingTextfield-Objc)
[![Build Status](https://travis-ci.org/ErAbhishekChandani/ACFloatingTextfield.svg?branch=master)](https://travis-ci.org/ErAbhishekChandani/ACFloatingTextfield)

UITextfield class to float the Placeholder and customize the placeholder while editing.

## Features

- [x] Add Floating effect In UITextfield Placeholder.
- [x] Change the Placeholder Text Color.
- [x] Change the Placeholder Text Color when UITextfield begins editing.
- [x] Add bottom line in.
- [x] Change the bottom line color.
- [x] Change the bottom line color when UITextfield begins editing.
- [x] Show error text, change the color of error text & line.
- [x] Change bottom line color when UITextField show error.
- [ ] The best is yet to come.

## Preview

![ACFloatingTextfieldGIF](https://github.com/ErAbhishekChandani/ACFloatingTextfield/blob/master/Example/ACFloatingTextifield.gif)

## Installation

<h3><a id="user-content-installation-with-cocoapods" class="anchor" href="#installation-with-cocoapods" aria-hidden="true"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Installation with CocoaPods</h3>

<p><a href="http://cocoapods.org">CocoaPods</a> is a dependency manager for Swift and Objective-C Cocoa projects.
which automates and simplifies the process of using 3rd-party libraries in your projects.
See the <a href="https://cocoapods.org/#get_started">Get Started</a> section for more details.
You can install it with the following command:</p>

<div class="highlight highlight-source-shell"><pre>$ sudo gem install cocoapods</pre></div>

<h4><a id="user-content-podfile" class="anchor" href="#podfile" aria-hidden="true"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Podfile</h4>

<p>To integrate ACFloatingTextfield into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, simply add the following line to your <code>Podfile</code>:</p>

<div class="highlight highlight-source-ruby"><pre> pod 'ACFloatingTextfield-Objc', '~> 1.6'
 <span class="pl-s"></span></pre></div>

<blockquote>
<p>If you are using <code>Swift</code>, be sure to add <code>use_frameworks!</code> in your <code>Podfile</code> and set your target to iOS 8+:</p>
</blockquote>

<pre><code>platform :ios, '8.0'
use_frameworks!
pod 'ACFloatingTextfield-Swift', '~> 1.5'

You can import ACFloatintextField in swift with @import ACFloatingTextfield_Swift .
</code></pre>

<p>Then, run the following command from Terminal:</p>

<pre><code>$ pod install
</code></pre>

<p>You should open the <code>{Project}.xcworkspace</code> instead of the <code>{Project}.xcodeproj</code> after you installed anything from CocoaPods.</p>

<pre><code>$ open *.xcworkspace 
</code></pre>

**Manual Installation**

Download the Sample and drag & drop the ACFloatingTextField.h and ACFloatingTextField.m or if using swift drag ACFloatingTextfield.swift file in your project.

## What's New

1. ACFloatingTextfield now works with swift 3.x .
2. Now you can show error validation text at bottom of line, also change the color of error text and line.

## How To Use.

**1) Add Textfield From Storyboard in View Controller and Set the class to ACFloatingTextField or create the textfield programmatically.**

**2) Set the Delegate.**

**3) Set Placeholder Text By Following Method.**

```objective-c

[(ACFloatingTextField *)textField setTextFieldPlaceholderText:@"Username"];

OR

acFloatingTextField.placeholder = @"";

```

**4)Implement the UITextfield Delegate method.**

```objective-c

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

[textField resignFirstResponder];
return YES;

}

```

##Customization

**1) Change the color of Bottom Line.** 

```objective-c

_textField.lineColor = [UIColor blueColor];

```

**2) Change the selected State color for Bottom Line.**

```objective-c

_textField.selectedLineColor = [UIColor orangeColor];

```

**3) Change the Placeholder Color.**

```objective-c

_textField.placeHolderTextColor = [UIColor redColor];

```

**4) Change the Selected Placeholder Color.**

```objective-c

_textField.selectedPlaceHolderTextColor = [UIColor greenColor];

```

**5) Change lineColor, selectedLineColor , placeHolderColor & selectedPlaceHolderColor From Storyboard in Swift version.**

**6) Change the Error Text Color.**

```objective-c

_textField.errorTextColor = [UIColor redColor];

```
**7) Change the bottom line color when show Error.**

```objective-c

_textField.errorLineColor = [UIColor redColor];

```
**8) Set Error Message.**

```objective-c

_textField.errorText = @"My Error";

```
**8) Show Error Message.**

```objective-c

[_textField showError];
[_textField showErrorWithText:@"This is New Error"];

```

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**,please submit a pull request.

## License

ACFloatingTextField is released under the MIT license. See LICENSE for details.
