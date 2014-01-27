//
//  FilterItem.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilterItem.h"



@implementation FilterItem

- (id) init
{
    if (self = [super init])
    {
        _selectableItems = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Class Methods

- (NSArray*) filterCourses:(NSArray *)courses
{
    if (_selectedItem && self.coursePredicate)
    {
        return [courses filteredArrayUsingPredicate: self.coursePredicate];
    }
    return courses;
}

- (NSArray*) filterStudents:(NSArray *)students
{
    if (_selectedItem && self.studentPredicate)
    {
        return [students filteredArrayUsingPredicate: self.studentPredicate];
    }
    return students;
}

- (NSPredicate*) coursePredicate
{
    return [NSPredicate predicateWithValue: YES];
}

- (NSPredicate*) studentPredicate
{
    return [NSPredicate predicateWithValue: YES];
}

- (void) reloadItems
{
    
}

- (UIImage*) imageForItem:(id)item
{
    return nil;
}

- (NSString*) titleForItem:(id)item
{
    return @"Häst";
}

- (UIImage*) imageForSelectedItem
{
    return nil;
}

- (NSString*) titleForSelectedItem
{
    return @"Ponny";
}

- (UIViewController*) newObjectPromptViewController
{
    return [[PromptViewController alloc] init];
}

- (NSInteger) indexForInsertSelectableItem: (id) item
{
    return 0;
}

- (void) deleteItemAtIndex:(NSInteger)index
{

}

#pragma mark - Getters and Setters

- (void) setSelectedItem:(id)selectedItem
{
    _selectedItem = selectedItem;
    [_delegate filterItemDidUpdate: self];
}

@synthesize selectableItems = _selectableItems;
@synthesize selectedItem = _selectedItem;
@synthesize delegate = _delegate;

@synthesize createNewBlock;
@synthesize editObjectBlock;

@end
