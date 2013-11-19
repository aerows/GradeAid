//
//  RegisterViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterViewController.h"
#import "Teacher+Create.h"
#import "AppDelegate.h"
#import "UIStoryboard+mainStoryboard.h"
#import "LoginViewController.h"
#import "Session.h"

@implementation RegisterViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        
    }
    return self;
}



- (void) viewDidLoad
{
    [super viewDidLoad];

    
    
}

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}


- (IBAction)registerTeacher:(id)sender
{
    [self controlInput];
    NSDictionary *attributes = @{ KeyForFirstName : firstNameTextField.text,
                                  KeyForLastName  : lastNameTextField.text,
                                  KeyForEmail     : emailTextField.text,
                                  KeyForPassword  : passwordTextField.text };
    
    Teacher *teacher = [Teacher teacherWithAttributes: attributes managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    
    if (teacher)
    {
        NSError *error = nil;
        [[AppDelegate sharedDelegate].managedObjectContext save: &error];
        if (error) NSLog(@"%@", error.description);
        
        [[Session currentSession] setTeacher: teacher];
        [self dismiss: self];
    }
}

- (void) controlInput
{
    
}

@end
