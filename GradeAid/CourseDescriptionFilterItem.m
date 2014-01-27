//
//  CourseDescriptionFilterItem.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CourseDescriptionFilterItem.h"

//Model
#import "Teacher+Create.h"

#import "Course+Create.h"
#import "CourseEdition+Create.h"
#import "CourseDescription+Create.h"

//Global
#import "Session.h"
#import "AppDelegate.h"

@implementation CourseDescriptionFilterItem

- (id) init
{
    if (self = [super init])
    {
        [self reloadItems];
    }
    return self;
}

#pragma mark - Subclass Methods

- (NSPredicate*) coursePredicate
{
    if (self.selectedItem)
    {
        CourseDescription *courseDescription = (CourseDescription*) self.selectedItem;
        return [NSPredicate predicateWithFormat: @"(courseEdition.courseDescription = %@)", courseDescription];
    }
    return [super coursePredicate];
}

- (NSPredicate*) studentPredicate
{
    if (self.selectedItem)
    {
        return [NSPredicate predicateWithFormat: @"(ANY enrollments.courseDescription = %@)", self.selectedItem];
    }
    return [super studentPredicate];
}

- (void) reloadItems
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseDescription"];
    //request.predicate = [NSPredicate predicateWithFormat: @"(SELF IN %@)", teacher.courseEditions];
    
    NSError *error;
    NSArray *response = [[AppDelegate sharedDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    if (!response)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    else
    {
        [_selectableItems setArray: response];
    }
    [self updateSelected];
}

- (UIImage*) imageForItem:(id)item
{
    if ([item isEqual: self.selectedItem])
    {
        return [UIImage imageNamed: @"selectedOneCourse"];
    }
    
    return [UIImage imageNamed: @"oneCourse"];
    return [Course defaultImage];
}

- (NSString*) titleForItem:(id)item
{
    CourseDescription *courseDescription = (CourseDescription*) item;
    return courseDescription.title;
}

- (UIImage*) imageForSelectedItem
{
    if (self.selectedItem)
    {
        return [self imageForItem: self.selectedItem];
    }
    
    return [UIImage imageNamed: @"manyCourses"];
}

- (NSString*) titleForSelectedItem
{
    if (self.selectedItem)
    {
        return [self titleForItem: self.selectedItem];
    }
    
    return @"Alla ämnen";
}

#pragma mark - Helper Methods

- (void) updateSelected
{
    
}

#pragma mark - Setters and Getters

@end