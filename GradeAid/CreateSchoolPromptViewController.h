//
//  SchoolPromptViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptCreateViewController.h"
#import "School+Create.h"

@interface CreateSchoolPromptViewController : PromptCreateViewController
{
    IBOutlet UITextField *_schoolNameTextField;
    IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) UITextField *schoolNameTextField;
@property (nonatomic, strong) UIImageView *imageView;

@end
