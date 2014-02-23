//
//  SchoolClassFilterItem.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilterItem.h"
#import "School+Create.h"

@interface SchoolClassFilterItem : FilterItem

@property (nonatomic, strong) School *selectedSchool;

@end