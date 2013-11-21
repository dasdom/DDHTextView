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

#import "DDHTextView.h"

#define kCursorVelocity 1.0f/8.0f

@interface DDHTextView ()
@property (nonatomic, strong) UIPanGestureRecognizer *singleFingerPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *doubleFingerPanRecognizer;
@property (nonatomic, assign) NSRange startRange;
@end

@implementation DDHTextView

- (id)init
{
    self = [super init];
    if (self) {
        _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
        _singleFingerPanRecognizer.maximumNumberOfTouches = 2;
        _singleFingerPanRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:_singleFingerPanRecognizer];
        
        _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
        _doubleFingerPanRecognizer.minimumNumberOfTouches = 3;
        [self addGestureRecognizer:_doubleFingerPanRecognizer];
    }
    return self;
}

- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer
{
    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
}

- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGPoint translation = [sender translationInView:self];
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)(translation.x*kCursorVelocity), 0);
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
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
