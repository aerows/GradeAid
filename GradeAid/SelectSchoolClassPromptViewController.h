//
//  SelectSchoolClassPromptViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptSelectViewController.h"
#import "Filter.h"
#import "School+Create.h"

@interface SelectSchoolClassPromptViewController : PromptSelectViewController

- (id) initWithFilter: (Filter*) filter;

@property (nonatomic, strong) School *school;

@end
