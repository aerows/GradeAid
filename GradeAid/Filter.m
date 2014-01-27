//
//  Filter.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-08.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "Filter.h"

//Model
#import "SchoolClass+Create.h"

@implementation Filter

- (id) init
{
    if (self = [super init])
    {
        _schoolFilterItem = [[SchoolFilterItem alloc] init];
        _schoolClassFilterItem = [[SchoolClassFilterItem alloc] init];
        //_courseFilterItem = [[CourseFilterItem alloc] init];
        _courseDescriptionFilterItem = [[CourseDescriptionFilterItem alloc] init];
        
        _filterItems = [[NSMutableArray alloc] initWithArray: @[_schoolFilterItem, _schoolClassFilterItem, _courseDescriptionFilterItem]];
        for (FilterItem *fi in _filterItems)
        {
            fi.delegate = self;
        }
    }
    return self;
}

#pragma mark - FilterItem Delegate Methods

- (void) filterItemDidUpdate:(FilterItem*) filterItem
{
    if ([filterItem isEqual: _schoolFilterItem])
    {
        [_schoolClassFilterItem setSelectedSchool: (School*) _schoolFilterItem.selectedItem];
        
        if (!_schoolFilterItem.selectedItem)
        {
            [_schoolClassFilterItem setSelectedItem: nil];
        }
    }
    
    else if ([filterItem isEqual: _schoolClassFilterItem])
    {
        if (_schoolClassFilterItem.selectedItem && !_schoolFilterItem.selectedItem)
        {
            SchoolClass* schoolClass = (SchoolClass*) _schoolClassFilterItem.selectedItem;
            [_schoolFilterItem setSelectedItem: schoolClass.school];
        }
    }
    else if ([filterItem isEqual: _courseDescriptionFilterItem])
    {
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName: FilterDidUpdateNotification object: self];
}

#pragma mark - Getters and Setters

@synthesize filterItems = _filterItems;

@synthesize schoolFilterItem = _schoolFilterItem;
@synthesize schoolClassFilterItem = _schoolClassFilterItem;
//@synthesize courseFilterItem = _courseFilterItem;
@synthesize courseDescriptionFilterItem = _courseDescriptionFilterItem;
@end
