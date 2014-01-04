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

CGFloat const DDHCursorVelocity = 1.0f/8.0f;

@interface DDHTextView ()
@property (nonatomic, strong) UIPanGestureRecognizer *singleFingerPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *doubleFingerPanRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapRecognizer;
@property (nonatomic, assign) NSRange startRange;
@end

@implementation DDHTextView

- (id)init {
    self = [super init];
    if (self) {
        [self setUpInputAccessoryView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpInputAccessoryView];
}

- (void)setUpInputAccessoryView {
    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] applicationFrame].size.width, 40.0f)];
    inputAccessoryView.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
    
    self.inputAccessoryView = inputAccessoryView;
    
    _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
    _singleFingerPanRecognizer.maximumNumberOfTouches = 1;
    [inputAccessoryView addGestureRecognizer:_singleFingerPanRecognizer];
    
    _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
    _doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
    [inputAccessoryView addGestureRecognizer:_doubleFingerPanRecognizer];
    
    _doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHappend:)];
    _doubleTapRecognizer.numberOfTapsRequired = 2;
    [inputAccessoryView addGestureRecognizer:_doubleTapRecognizer];
}

- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer {
    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
}

- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startRange = self.selectedRange;
    }
    
    CGPoint translation = [sender translationInView:self];
    CGFloat cursorLocation = MAX(_startRange.location+(NSInteger)(translation.x*DDHCursorVelocity), 0);
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(_startRange.location+(NSInteger)([sender translationInView:self].x*DDHCursorVelocity), 0);
    NSRange selectedRange;
    if (cursorLocation > self.startRange.location) {
        selectedRange = NSMakeRange(_startRange.location, fabsf(_startRange.location-cursorLocation));
    } else {
        selectedRange = NSMakeRange(cursorLocation, fabsf(_startRange.location-cursorLocation));
    }
    self.selectedRange = selectedRange;
}

- (void)doubleTapHappend:(UITapGestureRecognizer*)sender {
    CGRect hostViewFrame = sender.view.frame;
    CGPoint locationOfTouch = [sender locationInView:sender.view];
    if (locationOfTouch.x < 80.0f) {
        self.selectedRange = NSMakeRange(0, 0);
    } else if (locationOfTouch.x > hostViewFrame.size.width-80.0f) {
        self.selectedRange = NSMakeRange(self.text.length, 0);
    }
}

@end