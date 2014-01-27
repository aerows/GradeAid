//
//  CreateStudentPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CreateStudentPromptViewController.h"
#import "SelectSchoolClassPromptViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "AppDelegate.h"
#import "Student+Create.h"

@interface CreateStudentPromptViewController ()

@end

@implementation CreateStudentPromptViewController

- (id) initWithFilter:(Filter *)filter
{
    if (self = [self init])
    {
        SelectSchoolClassPromptViewController *selectSchoolClassPrompt = [[SelectSchoolClassPromptViewController alloc] initWithFilter: filter];
        selectSchoolClassPrompt.nextPromptViewController = self;
        self.previousPromptViewController = selectSchoolClassPrompt;
        [selectSchoolClassPrompt setDoneSelectingBlock: ^(PromptViewController *prompt, id object)
         {
             [((CreateStudentPromptViewController*) prompt.nextPromptViewController) setSchoolClass: (SchoolClass*)object];
             [prompt.navigationController pushViewController: prompt.nextPromptViewController animated: YES];
         }];
        _schoolClass = selectSchoolClassPrompt.object;
    }
    return self;
}

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"CreateStudentPromptViewController"];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [_studentFirstNameTextField addTarget: self action:@selector(revalidateInputs) forControlEvents:UIControlEventEditingChanged];
    [_studentLastNameTextField addTarget: self action:@selector(revalidateInputs) forControlEvents:UIControlEventEditingChanged];
}

#define redColor ()

- (bool) validateInputs
{
    return (_studentFirstNameTextField.text.length > 0) &&
           (_studentLastNameTextField.text.length > 0);
}

- (id) createObject
{
    Student *student = [Student studentWithDict: @{} inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];

    student.firstName = _studentFirstNameTextField.text;
    student.lastName = _studentLastNameTextField.text;
    student.schoolClass = _schoolClass;
        
    [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    return student;
}

#pragma mark - Getters and Setters

@synthesize studentFirstNameTextField = _studentFirstNameTextField;
@synthesize studentLastNameTextField = _studentLastNameTextField;
@synthesize schoolClass = _schoolClass;
@synthesize imageView = _imageView;

@end
