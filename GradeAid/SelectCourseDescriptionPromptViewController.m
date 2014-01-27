//
//  SelectCourseDescriptionPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SelectCourseDescriptionPromptViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "CourseDescription+Create.h"
#import "AppDelegate.h"

@interface SelectCourseDescriptionPromptViewController ()

@end

@implementation SelectCourseDescriptionPromptViewController

- (id) init
{
    if ((self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"SelectCourseDescriptionPromptViewController"]))
    {

    }
    return self;
}

- (void) reloadObjects
{
    self.objects = [CourseDescription allCourseDescriptionsInManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
}

- (UIImage*) imageForObject:(id)object
{
    return [UIImage imageNamed: @"oneCourse"];
}

- (NSString*) titleForObject:(id)object
{
    CourseDescription *courseDescription = (CourseDescription*) object;
    return courseDescription.title;
}

@end