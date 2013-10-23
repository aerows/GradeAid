//
//  HomeViewController2.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "HomeViewController2.h"

static CGPoint const PanBarUpperAnchorPoint = {384,238};
static CGPoint const PanBarLowerAnchorPoint = {384,786};
static CGFloat const AnimationDuration      = 0.5f;

@implementation HomeViewController2
{
    CGPoint currentAnchorPoint;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        currentAnchorPoint = PanBarUpperAnchorPoint;
        [self scrollViewsToAncherPoint: currentAnchorPoint];
    }
    return self;
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView: self.view];
    CGPoint newAnchorPoint = (CGPoint){currentAnchorPoint.x + translation.x,
                                       currentAnchorPoint.y + translation.y};
    
    [self scrollViewsToAncherPoint: newAnchorPoint];

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat middlePoint = (PanBarUpperAnchorPoint.y + PanBarLowerAnchorPoint.y) / 2;
        currentAnchorPoint = (recognizer.view.center.y < middlePoint) ? PanBarUpperAnchorPoint : PanBarLowerAnchorPoint;
    
        [UIView animateWithDuration: AnimationDuration
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
                         {
                             [self scrollViewsToAncherPoint: currentAnchorPoint];
                         }
                         completion:nil];
    }
}

- (void) scrollViewsToAncherPoint: (CGPoint) anchorPoint
{
    CGPoint absoluteAnchorPoint = (CGPoint){round(anchorPoint.x), round(anchorPoint.y)};
    _scrollHandle.center = (CGPoint){_scrollHandle.center.x, absoluteAnchorPoint.y};
    
    CGRect upperFrame = self.teacherView.frame;
    upperFrame.size.height = _scrollHandle.frame.origin.y - upperFrame.origin.y;
    self.teacherView.frame = upperFrame;
    
    CGRect lowerFrame = self.collectionView.frame;
    CGFloat lowerFrameNewY = _scrollHandle.frame.origin.y + _scrollHandle.frame.size.height;
    lowerFrame.size.height = lowerFrame.size.height + (lowerFrame.origin.y - lowerFrameNewY);
    lowerFrame.origin.y = lowerFrameNewY;
    self.collectionView.frame = lowerFrame;
}


@end
