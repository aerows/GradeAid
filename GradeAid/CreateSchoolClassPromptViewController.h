//
//  CreateSchoolClassPromptViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-13.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptCreateViewController.h"
#import "SchoolClass+Create.h"
#import "Filter.h"

@interface CreateSchoolClassPromptViewController : PromptCreateViewController
{
    IBOutlet UITextField *_schoolClassYearTextField;
    IBOutlet UITextField *_schoolClassSuffixTextField;
    IBOutlet UIImageView *_imageView;
}

- (id) initWithFilter: (Filter*) filter;

@property (nonatomic, strong) School *school;

@property (nonatomic, strong) UITextField *schoolClassYearTextField;
@property (nonatomic, strong) UITextField *schoolClassSuffixTextField;
@property (nonatomic, strong) UIImageView *imageView;

@end
