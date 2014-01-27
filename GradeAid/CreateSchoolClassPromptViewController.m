//
//  CreateSchoolClassPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-13.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CreateSchoolClassPromptViewController.h"
#import "SelectSchoolPromptViewController.h"

#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"
#import "Session.h"

@interface CreateSchoolClassPromptViewController ()

@end

@implementation CreateSchoolClassPromptViewController

- (id) initWithFilter:(Filter *)filter
{
    if (self = [self init])
    {
        SelectSchoolPromptViewController *selectSchoolPrompt = [[SelectSchoolPromptViewController alloc] initWithFilter: filter];
        selectSchoolPrompt.nextPromptViewController = self;
        self.previousPromptViewController = selectSchoolPrompt;
        [selectSchoolPrompt setDoneSelectingBlock: ^(PromptViewController *prompt, id object)
        {
            [((CreateSchoolClassPromptViewController*) prompt.nextPromptViewController) setSchool: (School*)object];
            [prompt.navigationController pushViewController: prompt.nextPromptViewController animated: YES];
        }];
        _school = selectSchoolPrompt.object;
    }
    return self;
}

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"CreateSchoolClassPromptViewController"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_schoolClassYearTextField addTarget: self action:@selector(revalidateInputs) forControlEvents:UIControlEventEditingChanged];
    
}

#define redColor ()

- (bool) validateInputs
{
    if (!_schoolClassYearTextField.text.length)
    {
        return NO;
        [_schoolClassYearTextField setBackgroundColor: [UIColor whiteColor]];
    }
    if (![self numberFromYearTextField])
    {
        [_schoolClassYearTextField setBackgroundColor: errorColor];
        return NO;
    }
    [_schoolClassYearTextField setBackgroundColor: [UIColor whiteColor]];
    return YES;
}

- (id) createObject
{
    SchoolClass *schoolClass = [SchoolClass schoolClassWithSchool: _school year: [self numberFromYearTextField] suffix: _schoolClassSuffixTextField.text highschool: @(NO) managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    
    [_school addClassesObject: schoolClass];
    [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    return schoolClass;
}

- (NSNumber*) numberFromYearTextField
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString: _schoolClassYearTextField.text];
}

#pragma mark - Getters and Setters

@synthesize schoolClassSuffixTextField = _schoolClassSuffixTextField;
@synthesize schoolClassYearTextField = _schoolClassYearTextField;
@synthesize school = _school;
@synthesize imageView = _imageView;


@end
