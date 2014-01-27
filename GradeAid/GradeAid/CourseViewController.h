//
//  CourseViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterObjectViewController.h"
#import "Course+Create.h"
#import "SellectionVerifyer.h"
#import "Subject+Create.h"
#import "TableViewDelegate.h"

#import "SubjectTableView.h"
#import "EnrollmentTableView.h"

@interface CourseViewController : UIViewController
{
    IBOutlet UIToolbar *_toolbar;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UITextField *_titleTextField;
    IBOutlet UIBarButtonItem *_titleItem;
    IBOutlet UISegmentedControl *_segmentedControl;
}

// Model
@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) CourseDescription *courseDescription;

// State
@property (nonatomic) bool inEditMode;
@property (nonatomic) bool inCreateMode;

// View
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *titleItem;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end
