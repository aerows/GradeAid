//
//  SchoolFilterItem.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SchoolFilterItem.h"

//Model
#import "Teacher+Create.h"
#import "School+Create.h"
#import "UIImage+Tint.h"

//Global
#import "Session.h"
#import "AppDelegate.h"
#import "UIStoryboard+mainStoryboard.h"

// View
#import "CreateSchoolPromptViewController.h"

@implementation SchoolFilterItem

- (id) init
{
    if (self = [super init])
    {
        [self reloadItems];
        self.editable = YES;
    }
    return self;
}

#pragma mark - Subclass Methods

- (NSPredicate*) coursePredicate
{
    if (self.selectedItem)
    {
        return [NSPredicate predicateWithFormat: @"(ANY enrollments.student.schoolClass.school = %@)", self.selectedItem];
    }
    return [super coursePredicate];
}

- (NSPredicate*) studentPredicate
{
    if (self.selectedItem)
    {
        return [NSPredicate predicateWithFormat: @"(schoolClass.school = %@)", self.selectedItem];
    }
    return [super studentPredicate];
}

- (void) reloadItems
{
    Teacher *teacher = [Session currentSession].teacher;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"School"];
    request.predicate = [NSPredicate predicateWithFormat: @"(SELF IN %@)", teacher.schools];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]];
    
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
}

- (UIImage*) imageForItem:(id)item
{
    if ([item isEqual: self.selectedItem])
    {
        return [UIImage imageNamed: @"selectedOneSchool"];
    }
    
    return [UIImage imageNamed: @"oneSchool"];
    
    School *school = (School*) item;
    return school.schoolImage;
}

- (NSString*) titleForItem:(id)item
{
    School *school = (School*) item;
    return school.name;
}

- (UIImage*) imageForSelectedItem
{
    if (self.selectedItem)
    {
        return [self imageForItem: self.selectedItem];
    }
    
    return [UIImage imageNamed: @"manySchools"];
}

- (NSString*) titleForSelectedItem
{
    if (self.selectedItem)
    {
        return [self titleForItem: self.selectedItem];
    }
    
    return @"Alla skolor";
}

- (PromptViewController*) newObjectPromptViewController
{
    return [[CreateSchoolPromptViewController alloc] init];
}

- (NSInteger) indexForInsertSelectableItem:(id)item
{
    School *school = (School*) item;
    [self reloadItems];
    return [self.selectableItems indexOfObject: school];
}

- (void) deleteItemAtIndex:(NSInteger)index
{
    School *school = [_selectableItems objectAtIndex: index];
    if ([self.selectedItem isEqual: school])
    {
        self.selectedItem = nil;
        [self.delegate filterItemDidUpdate: self];
    }
    [School deleteSchool: school];
    [self reloadItems];
}

@end
