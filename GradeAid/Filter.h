//
//  Filter.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-08.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "FilterItem.h"
#import "SchoolFilterItem.h"
#import "SchoolClassFilterItem.h"
#import "CourseFilterItem.h"
#import "CourseDescriptionFilterItem.h"

static NSString *const FilterDidUpdateNotification = @"FilterDidUpdateNotification";

@interface Filter : NSObject<FilterItemDelegate>

@property (nonatomic, strong) SchoolFilterItem *schoolFilterItem;
@property (nonatomic, strong) SchoolClassFilterItem *schoolClassFilterItem;
//@property (nonatomic, strong) CourseFilterItem *courseFilterItem;
@property (nonatomic, strong) CourseDescriptionFilterItem *courseDescriptionFilterItem;

@property (nonatomic, strong) NSMutableArray *filterItems;

@end
