//
//  SelectSchoolPromptViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-13.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptSelectViewController.h"
#import "School+Create.h"
#import "Filter.h"

@interface SelectSchoolPromptViewController : PromptSelectViewController

- (id) initWithFilter: (Filter*) filter;

@end
