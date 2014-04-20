//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2014 Dominik Hauser
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "DemoViewController.h"
#import "DDHTextView.h"

@interface DemoViewController ()
@property (nonatomic, strong) DDHTextView *textView;
@end

@implementation DemoViewController

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    
    _textView = [[DDHTextView alloc] init];
    _textView.inputAccessoryViewBackgroundColor = [UIColor redColor];
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    _textView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    _textView.text = @"This gray area is a textview. Pan left and right on the area above the keyboard to move the cursor.\nPan on that area with two fingers to select text.\nDouble tap at the left (right) edge to move the cursor to the beginning (end).";
    [contentView addSubview:_textView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textView);
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_textView]|" options:0 metrics:nil views:viewsDictionary]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_textView(100)]" options:0 metrics:nil views:viewsDictionary]];

 
    self.view = contentView;
}

- (void)viewDidAppear:(BOOL)animated {
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
