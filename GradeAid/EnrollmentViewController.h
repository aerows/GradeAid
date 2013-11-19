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

static NSString *const EnrollmentStoryboardIdentifier = @"EnrollmentViewController";

@interface EnrollmentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, CourseTableDelegate>

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) Enrollment *enrollment;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *courseAquirementFetchController;

@end
