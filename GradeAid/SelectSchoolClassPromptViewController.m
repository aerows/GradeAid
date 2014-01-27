//
//  SelectSchoolClassPromptViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "SelectSchoolClassPromptViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "SelectSchoolPromptViewController.h"

@interface SelectSchoolClassPromptViewController ()

@end

@implementation SelectSchoolClassPromptViewController

- (id) initWithFilter:(Filter *)filter
{
    if (self = [self init])
    {
        SelectSchoolPromptViewController *selectSchoolPrompt = [[SelectSchoolPromptViewController alloc] initWithFilter: filter];
        selectSchoolPrompt.nextPromptViewController = self;
        self.previousPromptViewController = selectSchoolPrompt;
        [selectSchoolPrompt setDoneSelectingBlock: ^(PromptViewController *prompt, id object)
         {
             [((SelectSchoolClassPromptViewController*) prompt.nextPromptViewController) setSchool: (School*)object];
             [prompt.navigationController pushViewController: prompt.nextPromptViewController animated: YES];
         }];
        
        self.object = filter.schoolClassFilterItem.selectedItem;
        if (filter.schoolClassFilterItem.selectableItems.count == 1)
        {
            self.object = filter.schoolClassFilterItem.selectableItems.lastObject;
        }
        if (self.object)
        {
            self.school = ((SchoolClass*) self.object).school;
            selectSchoolPrompt.object = ((SchoolClass*) self.object).school;
        } else {
            _school = selectSchoolPrompt.object;
        }
    }
    return self;
}

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"SelectSchoolClassPromptViewController"];
    return self;
}

- (void) reloadObjects
{
    if (_school)
    {
        self.objects = [SchoolClass schoolClassesForSchool: _school];
    }
}

- (UIImage*) imageForObject:(id)object
{
    return [UIImage imageNamed: @"oneClass"];
}

- (NSString*) titleForObject:(id)object
{
    SchoolClass *schoolClass = (SchoolClass*) object;
    return schoolClass.fullSchoolClassName;
}

@synthesize school = _school;

@end