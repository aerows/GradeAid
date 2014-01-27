//
//  CourseFilterItem.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CourseFilterItem.h"

//Model
#import "Teacher+Create.h"

#import "Course+Create.h"
#import "CourseEdition+Create.h"
#import "CourseDescription+Create.h"

//Global
#import "Session.h"
#import "AppDelegate.h"

@implementation CourseFilterItem

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
        CourseEdition *courseEdition = (CourseEdition*) self.selectedItem;
        return [NSPredicate predicateWithFormat: @"(courseEdition = %@)", courseEdition];
    }
    return [super coursePredicate];
}

- (NSPredicate*) studentPredicate
{
    if (self.selectedItem)
    {
        return [NSPredicate predicateWithFormat: @"(ANY enrollments.course.courseEdition = %@)", self.selectedItem];
    }
    return [super studentPredicate];
}

- (void) reloadItems
{
    Teacher *teacher = [Session currentSession].teacher;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseEdition"];
    request.predicate = [NSPredicate predicateWithFormat: @"(SELF IN %@)", teacher.courseEditions];

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
    CourseEdition *courseEdition = (CourseEdition*) item;
    return courseEdition.courseDescription.title;
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
