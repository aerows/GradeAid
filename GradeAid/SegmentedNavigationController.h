//
//  SegmentedNavigationController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedNavigationController : UIViewController
{
    NSMutableArray *_viewControllers;
    UIViewController *_currentViewController;
    NSMutableArray *_viewControllerTitles;
    
    IBOutlet UISegmentedControl *_segmentedControl;
    NSInteger _currentSegmentIndex;
}

- (CGRect) subviewControllerFrame;
- (void) willPresentViewControllerWithIndex: (NSInteger) index;

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) NSArray *viewControllerTitles;

@end
