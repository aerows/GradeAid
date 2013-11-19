//
//  CourseViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Create.h"

#import "CourseTableViewController.h"
#import "EnrollmentViewController.h"

@interface CourseViewController : UISplitViewController
{
    IBOutlet CourseTableViewController *_courseTableViewController;
    IBOutlet EnrollmentViewController *_enrollmentViewController;
}

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) Enrollment *sellectedEnrollment;

@property (nonatomic, strong) CourseTableViewController *courseTableViewController;
@property (nonatomic, strong) EnrollmentViewController *enrollmentViewController;

@end
