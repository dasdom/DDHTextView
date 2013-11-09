//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Dominik Hauser
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

@end

@implementation DemoViewController

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    
    DDHTextView *textView = [[DDHTextView alloc] init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    textView.text = @"This gray area is a textview. Tap it with your finger to enter edit mode. In edit mode you can pan right and left with your finger to move the cursor.\nPan with two fingers to select text.";
    [contentView addSubview:textView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(textView);
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[textView]|" options:0 metrics:nil views:viewsDictionary]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[textView(200)]" options:0 metrics:nil views:viewsDictionary]];

 
    self.view = contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
