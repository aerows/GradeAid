//
//  CourseCollectionViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "CourseCollectionViewCell.h"
#import "CourseEdition+Create.h"
#import "CourseDescription+Create.h"
#import "SchoolClass+Create.h"
#import "UILabel+listObjects.h"

@implementation CourseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Update View Methods

- (void) updateView
{
    CourseDescription *desc = _course.courseEdition.courseDescription;
    [_titleLabel setText: [NSString stringWithFormat: @"%@, %@", desc.name, desc.level]];

    [_descriptionLabel setText: _course.name];
    
    NSArray *schoolClasseNames = [_course.schoolClasses valueForKeyPath: @"fullSchoolClassName"];
    [_classesLabel listObjects: schoolClasseNames lineBreak: NO];

    NSArray *studentNames = [_course.students valueForKeyPath: @"fullName"];
    [_studentsLabel listObjects: studentNames lineBreak: YES];
}

#pragma mark - Getters and Setters

- (void) setCourse:(Course *)course
{
    _course = course;
    [self updateView];
    
}

@synthesize course = _course;

@end
