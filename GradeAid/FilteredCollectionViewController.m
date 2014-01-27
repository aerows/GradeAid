//
//  FilteredCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilteredCollectionViewController.h"

@interface FilteredCollectionViewController ()

@end

@implementation FilteredCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupWithFilter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupWithFilter
{
    // To be subclassed
}

#pragma mark - View Appearance Methods


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(filterDidUpdate:) name: FilterDidUpdateNotification object: _filter];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark - FilterDelegateUpdate

- (void) filterDidUpdate:(NSNotification*) notification
{
    [self setupWithFilter];
}

@end
