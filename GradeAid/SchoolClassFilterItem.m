//
//  SchoolClassFilterItem.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SchoolClassFilterItem.h"

//Model
#import "Teacher+Create.h"
#import "SchoolClass+Create.h"

//Global
#import "Session.h"
#import "AppDelegate.h"
#import "CreateSchoolClassPromptViewController.h"

@implementation SchoolClassFilterItem

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
        return [NSPredicate predicateWithFormat: @"(ANY enrollments.student.schoolClass = %@)", self.selectedItem];
    }
    return [super coursePredicate];
}

- (NSPredicate*) studentPredicate
{
    if (self.selectedItem)
    {
        return [NSPredicate predicateWithFormat: @"(schoolClass = %@)", self.selectedItem];
    }
    return [super studentPredicate];
}

- (void) reloadItems
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"SchoolClass"];
    if (_selectedSchool)
    {
        request.predicate = [NSPredicate predicateWithFormat: @"(SELF IN %@)", _selectedSchool.classes];
    }
    else
    {
        Teacher *teacher = [Session currentSession].teacher;
        request.predicate = [NSPredicate predicateWithFormat: @"(school IN %@)", teacher.schools];
    }
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"school.name" ascending: YES],
                                [NSSortDescriptor sortDescriptorWithKey: @"year" ascending: YES],
                                [NSSortDescriptor sortDescriptorWithKey: @"suffix" ascending: YES]];
    
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
        return [UIImage imageNamed: @"selectedOneClass"];
    }
    
    return [UIImage imageNamed: @"oneClass"];

    SchoolClass *schoolClass = (SchoolClass*) item;
    return schoolClass.schoolClassImage;
}

- (NSString*) titleForItem:(id)item
{
    SchoolClass *schoolClass = (SchoolClass*) item;
    return schoolClass.fullSchoolClassName;
}

- (UIImage*) imageForSelectedItem
{
    if (self.selectedItem)
    {
        return [self imageForItem: self.selectedItem];
    }
    
    return [UIImage imageNamed: @"manyClasses"];
}

- (NSString*) titleForSelectedItem
{
    if (self.selectedItem)
    {
        return [self titleForItem: self.selectedItem];
    }
    
    return @"Alla klasser";
}

#pragma mark - Helper Methods

- (void) updateSelected
{
    if (![_selectableItems containsObject: self.selectedItem])
    {
        self.selectedItem = nil;
    }
    
    if (_selectableItems.count == 1)
    {
        self.selectedItem = _selectableItems.lastObject;
    }
}

- (PromptViewController*) newObjectPromptViewController
{
    Filter *filter = (Filter*) self.delegate;
    return [[CreateSchoolClassPromptViewController alloc] initWithFilter: filter];
}

- (NSInteger) indexForInsertSelectableItem:(id)item
{
    SchoolClass *schoolClass = (SchoolClass*) item;
    [self reloadItems];
    return [self.selectableItems indexOfObject: schoolClass];
}

- (void) deleteItemAtIndex:(NSInteger)index
{
    SchoolClass *schoolClass = [_selectableItems objectAtIndex: index];
    if ([self.selectedItem isEqual: schoolClass])
    {
        self.selectedItem = nil;
        [self.delegate filterItemDidUpdate: self];
    }
    [SchoolClass deleteSchoolClass: schoolClass];
    [self reloadItems];
}

#pragma mark - Setters and Getters

- (void) setSelectedSchool:(School *)selectedSchool
{
    _selectedSchool = selectedSchool;
    [self reloadItems];
}

@synthesize selectedSchool = _selectedSchool;

@end

