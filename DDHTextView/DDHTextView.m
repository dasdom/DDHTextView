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

#import "DDHTextView.h"

CGFloat const DDHCursorDefaultVelocity = 1.0f/8.0f;

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
        self.cursorVelocity = DDHCursorDefaultVelocity;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpInputAccessoryView];
}

/**
 *  Create and setup the input accessory view.
 */
- (void)setUpInputAccessoryView {
    UIView *inputAccessoryView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] applicationFrame].size.width, 40.0f)];
        view.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
        view;
    });
    self.inputAccessoryView = inputAccessoryView;
    
    self.singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
    self.singleFingerPanRecognizer.maximumNumberOfTouches = 1;
    [inputAccessoryView addGestureRecognizer:self.singleFingerPanRecognizer];
    
    self.doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
    self.doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
    [inputAccessoryView addGestureRecognizer:self.doubleFingerPanRecognizer];
    
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHappend:)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    [inputAccessoryView addGestureRecognizer:self.doubleTapRecognizer];
}

/**
 *  This method lets add a geture recognizer which must fail before the
 *  pan of the finger(s) is recognized.
 *
 *  @param gestureRecognizer the gesture recognizer which has to fail
 */
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer {
    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
}

#pragma mark - Gesture recogniser actions
/**
 *  Handles one finger pan gesture
 *
 *  @param sender the gesture recognizer
 */
- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender {
    // When the gesture starts store the range.
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startRange = self.selectedRange;
    }
    
    // Get the translation of the gesture
    CGPoint translation = [sender translationInView:self];
    
    // Calculate the new location of the cursor
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)(translation.x*self.cursorVelocity), 0);
    
    // Set the range.
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

/**
 *  Handles two finger pan gesture
 *
 *  @param sender the gesture recognizer
 */
- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender {
    // When the gesture starts store the range.
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startRange = self.selectedRange;
    }
    
    // Calculate the new location of the cursor
    CGFloat cursorLocation = MAX(_startRange.location+(NSInteger)([sender translationInView:self].x*self.cursorVelocity), 0);
    NSRange selectedRange;

    // Calculate the new selected range.
    if (cursorLocation > self.startRange.location) {
        selectedRange = NSMakeRange(self.startRange.location, fabsf(self.startRange.location-cursorLocation));
    } else {
        selectedRange = NSMakeRange(cursorLocation, fabsf(self.startRange.location-cursorLocation));
    }
    self.selectedRange = selectedRange;
}

/**
 *  Handles double tap gesture
 *
 *  @param sender the gesture recognizer
 */
- (void)doubleTapHappend:(UITapGestureRecognizer*)sender {
    // Figure out where the double tap happend
    CGRect hostViewFrame = sender.view.frame;
    CGPoint locationOfTouch = [sender locationInView:sender.view];
    
    if (locationOfTouch.x < 80.0f) {
        // If the double tap was on the left side of the view, move cursor to 0.
        self.selectedRange = NSMakeRange(0, 0);
    } else if (locationOfTouch.x > hostViewFrame.size.width-80.0f) {
        // If the double tap was on the right side of the view, move the cursor to the end.
        self.selectedRange = NSMakeRange(self.text.length, 0);
    }
}

#pragma mark - View methods
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.inputAccessoryViewBackgroundColor) {
        self.inputAccessoryView.backgroundColor = self.inputAccessoryViewBackgroundColor;
    }
}

@end