//
//  CourseEnrollmentSuiteViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model
#import "Enrollment+Create.h"
#import "Course+Create.h"

// Views
#import "CourseViewController.h"
#import "EnrollmentViewController.h"

@interface CourseEnrollmentSuiteViewController : UIViewController
{
    CourseViewController *_courseViewController;
    EnrollmentViewController *_enrollmentViewController;
}

- (id) initWithCourse: (Course*) course;
- (id) initWithCourseDescription: (CourseDescription*) courseDescription;

@property (nonatomic, strong) CourseViewController *courseViewController;
@property (nonatomic, strong) EnrollmentViewController *enrollmentViewController;

@end
