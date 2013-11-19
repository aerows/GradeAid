//
//  CourseViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseViewController.h"

@interface CourseViewController ()

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [_courseTableViewController setCourse: _course];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize course = _course;
@synthesize sellectedEnrollment = _sellectedEnrollment;

@synthesize courseTableViewController = _courseTableViewController;
@synthesize enrollmentViewController = _enrollmentViewController;

@end
