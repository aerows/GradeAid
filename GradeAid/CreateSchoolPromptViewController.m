//
//  SchoolPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CreateSchoolPromptViewController.h"
#import "Teacher+Create.h"


#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"
#import "Session.h"

@interface CreateSchoolPromptViewController ()

@end

@implementation CreateSchoolPromptViewController

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"CreateSchoolPromptViewController"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_schoolNameTextField addTarget: self action:@selector(revalidateInputs) forControlEvents:UIControlEventEditingChanged];
}

- (bool) validateInputs
{
    return _schoolNameTextField.text.length;
}

- (id) createObject
{
    School *school = [School schoolWithDict: @{} inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    school.name = _schoolNameTextField.text;
    [[Session currentSession].teacher addSchoolsObject: school];
    [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    return school;
}

#pragma mark - Getters and Setters

@synthesize schoolNameTextField = _schoolNameTextField;
@synthesize imageView = _imageView;

@synthesize nextPromptViewController = _nextPromptViewController;

- (void) setNextPromptViewController:(PromptViewController *)nextPromptViewController
{
    _nextPromptViewController = nextPromptViewController;
    UIBarButtonItem *backToSchool = [[UIBarButtonItem alloc] initWithTitle: @"Skolor" style:UIBarButtonItemStylePlain target: nil action: nil];
    [_nextPromptViewController.navigationItem setBackBarButtonItem: backToSchool];
}

@end
