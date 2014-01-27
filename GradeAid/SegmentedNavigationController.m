//
//  SegmentedNavigationController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SegmentedNavigationController.h"

@interface SegmentedNavigationController ()

@end

@implementation SegmentedNavigationController

#pragma mark - Constructor Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self initialize];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    _viewControllers = [[NSMutableArray alloc] init];
    _viewControllerTitles = [[NSMutableArray alloc] init];
}

#pragma mark - View Appearence Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_segmentedControl addTarget: self action: @selector(segmentChanged:) forControlEvents: UIControlEventValueChanged];
    
    [_currentViewController removeFromParentViewController];
    [_currentViewController.view removeFromSuperview];
    
    _currentSegmentIndex = 0;
    [_segmentedControl setSelectedSegmentIndex: _currentSegmentIndex];
    _currentViewController = [_viewControllers objectAtIndex: _currentSegmentIndex];
    _currentViewController.view.frame = [self subviewControllerFrame];
    
    [self addChildViewController: _currentViewController];
    [self.view addSubview: _currentViewController.view];
}

#pragma mark - SegmentChanged

static int const transitionDirectionLeft  = 1;
static int const transitionDirectionRight = 2;

- (void) segmentChanged:(UISegmentedControl *) sender
{
    [self willPresentViewControllerWithIndex: sender.selectedSegmentIndex];
    
    NSInteger previousSegmentIndex = _currentSegmentIndex;
    _currentSegmentIndex = sender.selectedSegmentIndex;
    
    UIViewController *previousViewController = _currentViewController;
    _currentViewController = [_viewControllers objectAtIndex: _currentSegmentIndex];
    
    int transitionDirection = (previousSegmentIndex < _currentSegmentIndex) ? transitionDirectionLeft : transitionDirectionRight;
    
    CGRect currentVCStartingFrame = [self subviewControllerFrame];
    CGRect previousVCEndingFrame  = [self subviewControllerFrame];
    
    if (transitionDirection == transitionDirectionLeft)
    {
        currentVCStartingFrame.origin.x += [self subviewControllerFrame].size.width;
        previousVCEndingFrame.origin.x -= [self subviewControllerFrame].size.width;
    }
    else if (transitionDirection == transitionDirectionRight)
    {
        currentVCStartingFrame.origin.x -= [self subviewControllerFrame].size.width;
        previousVCEndingFrame.origin.x += [self subviewControllerFrame].size.width;
    }
    
    [self addChildViewController: _currentViewController];
    _currentViewController.view.frame = currentVCStartingFrame;
    [self.view addSubview: _currentViewController.view];
    
    [UIView animateWithDuration: 0.4 animations:^{
        [_currentViewController.view setFrame: [self subviewControllerFrame]];
        [previousViewController.view setFrame: previousVCEndingFrame];
    } completion:^(BOOL finished) {
        [previousViewController.view removeFromSuperview];
        [_currentViewController didMoveToParentViewController: self];
        [previousViewController removeFromParentViewController];
    }];
}

- (CGRect) subviewControllerFrame
{
    // To be subclassed
    return CGRectMake(0, 97, 768, 927);
}

- (void) willPresentViewControllerWithIndex:(NSInteger)index
{
    
}

#pragma mark - Getters and Setters

@synthesize viewControllers = _viewControllers;
@synthesize viewControllerTitles = _viewControllerTitles;
@synthesize currentViewController = _currentViewController;


@end
