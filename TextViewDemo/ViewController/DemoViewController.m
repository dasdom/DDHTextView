//
//  DemoViewController.m
//  TextViewDemo
//
//  Created by dasdom on 09.11.13.
//  Copyright (c) 2013 dasdom. All rights reserved.
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
