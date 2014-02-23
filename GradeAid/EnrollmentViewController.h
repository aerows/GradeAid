//
//  CourseViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Create.h"
#import "Enrollment+Create.h"
#import "CourseTableViewController.h"

#import "SegmentedNavigationController.h"

static NSString *const EnrollmentStoryboardIdentifier = @"EnrollmentViewController";

@interface EnrollmentViewController : SegmentedNavigationController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, CourseTableDelegate>
{
    IBOutlet UILabel     *_courseNameLabel;
    IBOutlet UILabel     *_studentNameLabel;
    IBOutlet UILabel     *_studentSchoolClassLabel;
    
    IBOutlet UIButton    *_nextStudentButton;
    IBOutlet UIButton    *_previousStudentButton;
    
    IBOutlet UITableView *_tableView;
    IBOutlet UIBarButtonItem *_doneButton;
    IBOutlet UIBarButtonItem *_popdownStudentButton;
    
    IBOutlet UIButton    *_penButton;
    IBOutlet UIButton    *_editButton;
    IBOutlet UIButton    *_cancelEditingButton;
}

@property (nonatomic) bool isEditing;

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) Enrollment *enrollment;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *courseAquirementFetchController;

@end
