//
//  MultiSegmentedNavigationController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "MultiSegmentedNavigationController.h"

@interface MultiSegmentedNavigationController ()

@end

@implementation MultiSegmentedNavigationController
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
    [self setViewControllerTitles: _viewControllerTitles];
    
    [_segmentedControl setDelegate: self];
    
    _previousSegmentIndexSet = [NSIndexSet indexSetWithIndexesInRange: (NSRange){0,0}];
    _currentSegmentIndexSet  = [NSIndexSet indexSetWithIndex: 0];
    
    [_segmentedControl setSelectedSegmentIndexes: _currentSegmentIndexSet];
    [self presentViewControllersWithCurrentIndexSet];
}

#pragma mark - SegmentChanged

- (void) multiSelect:(MultiSelectSegmentedControl *) multiSelecSegmendedControl didChangeValue:(BOOL)value atIndex:(NSUInteger)index
{
    _previousSegmentIndexSet = _currentSegmentIndexSet;
    _currentSegmentIndexSet = [self updateIndexSet: _previousSegmentIndexSet withValue: value atIndex: index];
    
    [multiSelecSegmendedControl setSelectedSegmentIndexes: _currentSegmentIndexSet];
    if ([_currentSegmentIndexSet isEqualToIndexSet: _previousSegmentIndexSet]) return;
    
    [self presentViewControllersWithCurrentIndexSet];
}

- (NSIndexSet*) updateIndexSet: (NSIndexSet*) indexSet withValue: (BOOL) value atIndex: (NSUInteger) index
{
    if (indexSet.count == 1)
    {
        if (indexSet.lastIndex == index) return indexSet;
        return [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, 2)];
    }
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex: index];

    return set;
}

- (void) presentViewControllersWithCurrentIndexSet
{
    [_currentSegmentIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (![_previousSegmentIndexSet containsIndex: idx])
        {
            UIViewController *vc = [_viewControllers objectAtIndex: idx];
            [vc.view setClipsToBounds: YES];
            [vc.view setAutoresizesSubviews: YES];
            NSUInteger previousIndex = [_previousSegmentIndexSet indexLessThanIndex: idx];
            CGFloat x = (previousIndex == NSNotFound) ? 0.f : CGRectGetMaxX([[_viewControllers objectAtIndex: previousIndex] view].frame);
            
            
            CGRect frame = [self subviewControllerFrame];
            frame.origin.x = x;
            frame.size.width = 0.f;
            [vc.view setFrame: frame];
            [vc didMoveToParentViewController: self];
            [self.view addSubview: vc.view];
        }
    }];
    
    __block CGFloat x = 0;
    __block CGFloat fullWidth = [self subviewControllerFrame].size.width / _currentSegmentIndexSet.count;
    
    [UIView animateWithDuration: 0.4 animations:^{
        for (NSInteger i = 0; i < _viewControllers.count; i++)
        {
            CGFloat width = ([_currentSegmentIndexSet containsIndex: i]) ? fullWidth : 0.f;
            CGRect frame = [[_viewControllers objectAtIndex: i] view].frame;
            frame.origin.x = x;
            frame.size.width = width;
            x += width;
            [[[_viewControllers objectAtIndex: i] view] setFrame: frame];
        }
    } completion:^(BOOL finished) {
        for (NSInteger i = 0; i < _viewControllers.count; i++)
        {
            if (![_currentSegmentIndexSet containsIndex: i])
            {
                [[[_viewControllers objectAtIndex: i] view] removeFromSuperview];
                [[_viewControllers objectAtIndex: i] removeFromParentViewController];
            }
        }
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

- (void) setViewControllerTitles:(NSArray *)viewControllerTitles
{
    [_viewControllerTitles setArray: viewControllerTitles];
    
    for (int i = 0; i < MIN(_viewControllerTitles.count, _segmentedControl.numberOfSegments); i++)
    {
        [_segmentedControl setTitle: [_viewControllerTitles objectAtIndex: i] forSegmentAtIndex: i];
    }
}

@synthesize viewControllers = _viewControllers;
@synthesize viewControllerTitles = _viewControllerTitles;

@end

