//
//  CreateStudentPromptViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptCreateViewController.h"
#import "Filter.h"
#import "School+Create.h"

@interface CreateStudentPromptViewController : PromptCreateViewController
{
    IBOutlet UITextField *_studentFirstNameTextField;
    IBOutlet UITextField *_studentLastNameTextField;
    IBOutlet UIImageView *_imageView;
}

- (id) initWithFilter: (Filter*) filter;

@property (nonatomic, strong) SchoolClass *schoolClass;

@property (nonatomic, strong) UITextField *studentFirstNameTextField;
@property (nonatomic, strong) UITextField *studentLastNameTextField;
@property (nonatomic, strong) UIImageView *imageView;

@end