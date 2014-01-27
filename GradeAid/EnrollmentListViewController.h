//
//  EnrollmentListViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnrollmentTableView.h"
#import "Enrollment+Create.h"
#import "Course+Create.h"

@interface EnrollmentListViewController : UIViewController<TableViewDelegate>
{
    IBOutlet EnrollmentTableView *_enrollmentTableView;
    IBOutlet UILabel *_studentsLabel;
    IBOutlet UIButton *_addStudentsButton;
    IBOutlet UILabel *noStudentsLabel;
}

// Model
@property (nonatomic, strong) Course *course;

// State
@property (nonatomic) bool inEditMode;

// View
@property (nonatomic, strong) EnrollmentTableView *enrollmentTableView;
@property (nonatomic, strong) UILabel *studensLabel;
@property (nonatomic, strong) UIButton *addStudentsButton;
@property (nonatomic, strong) UILabel *noStudentsLabel;

@end
