//
//  DDHTextView.m
//  TextViewDemo
//
//  Created by dasdom on 09.11.13.
//  Copyright (c) 2013 dasdom. All rights reserved.
//

#import "DDHTextView.h"

@interface DDHTextView ()
@property (nonatomic, assign) NSRange startRange;
@end

@implementation DDHTextView

- (id)init
{
    self = [super init];
    if (self) {
        UIPanGestureRecognizer *singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
        singleFingerPanRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:singleFingerPanRecognizer];
        
        UIPanGestureRecognizer *doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
        doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:doubleFingerPanRecognizer];
    }
    return self;
}

- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x/8.0f), 0);
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x/8.0f), 0);
    NSRange selectedRange;
    if (cursorLocation > self.startRange.location)
    {
        selectedRange = NSMakeRange(self.startRange.location, fabsf(self.startRange.location-cursorLocation));
    }
    else
    {
        selectedRange = NSMakeRange(cursorLocation, fabsf(self.startRange.location-cursorLocation));
    }
    self.selectedRange = selectedRange;
}

@end
