//
//  SelectSchoolPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-13.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SelectSchoolPromptViewController.h"
#import "UIStoryboard+mainStoryboard.h"

@interface SelectSchoolPromptViewController ()

@end

@implementation SelectSchoolPromptViewController

- (id) initWithFilter:(Filter *)filter
{
    if (self = [self init])
    {
        [self reloadObjects];
        self.object = filter.schoolFilterItem.selectedItem;
        if (filter.schoolFilterItem.selectableItems.count == 1)
        {
            self.object = filter.schoolFilterItem.selectableItems.lastObject;
        }
    }
    return self;
}

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"SelectSchoolPromptViewController"];
    return self;
}

- (void) reloadObjects
{
    [self setObjects: [School schoolsForCurrentTeacher]];
}

- (UIImage*) imageForObject:(id)object
{
    return [UIImage imageNamed: @"oneSchool"];
}

- (NSString*) titleForObject:(id)object
{
    School *school = (School*) object;
    return school.name;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
