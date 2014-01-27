//
//  PromptCreateViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptCreateViewController.h"

@interface PromptCreateViewController ()

@end

@implementation PromptCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Klar" style: UIBarButtonItemStylePlain target: self action: @selector(doneButtonPressed)];
    [self.navigationItem setRightBarButtonItem: _doneButton];


    [self revalidateInputs];
}

- (void) cancelButtonPressed
{
    if (_cancelBlock)
    {
        _cancelBlock(self);
    }
    [self dismiss];
}

- (void) doneButtonPressed
{
    self.object = [self createObject];
    _doneCreatingBlock(self, self.object);
    [self.delegate promptViewController: self didCreatedObject: self.object];
}

#pragma mark - Prompt Create Methods

- (void) revalidateInputs
{
    [_doneButton setEnabled: [self validateInputs]];
}

- (bool) validateInputs
{
    // To be subclassed
    return NO;
}

- (id) createObject
{
    // To Be subclassed
    return nil;
}

#pragma mark - Setters and Getters

@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;

@synthesize cancelBlock = _cancelBlock;

@end
