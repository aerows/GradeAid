//
//  EnrollmentTableView.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-27.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Create.h"
#import "TableViewDelegate.h"

static NSString *const EnrolllmentWasSelectedNotification = @"EnrollmentWasSelectedNotification";

@interface EnrollmentTableView : UITableView<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) id<TableViewDelegate> tableViewDelegate;

// state

@property (nonatomic) bool inEditMode;

- (CGFloat) height;

@end
