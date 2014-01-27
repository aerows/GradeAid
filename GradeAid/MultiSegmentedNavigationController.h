//
//  MultiSegmentedNavigationController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSelectSegmentedControl.h"

@interface MultiSegmentedNavigationController : UIViewController<MultiSelectSegmentedControlDelegate>
{
    NSMutableArray *_viewControllers;
    NSMutableArray *_viewControllerTitles;
    
    IBOutlet MultiSelectSegmentedControl *_segmentedControl;
    NSIndexSet *_currentSegmentIndexSet;
    NSIndexSet *_previousSegmentIndexSet;
}

- (CGRect) subviewControllerFrame;
- (void) willPresentViewControllerWithIndex: (NSInteger) index;

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *viewControllerTitles;

@end