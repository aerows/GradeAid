//
//  PromptViewController2.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptViewController.h"
#import "Filter.h"

@interface PromptViewController ()

@end

@implementation PromptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.previousPromptViewController)
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Avbryt" style: UIBarButtonItemStylePlain target: self action: @selector(dismiss)];
        [self.navigationItem setLeftBarButtonItem: cancelButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (bool) validateInputs
{
    return YES;
}

- (void) dismiss
{
    [_enviorment dismissPromptViewController: self animated: YES];
}

#pragma mark - Getters and Setters

@synthesize object = _object;
@synthesize enviorment = _enviorment;
@synthesize nextPromptViewController = _nextPromptViewController;
@synthesize previousPromptViewController = _previousPromptViewController;

@end
