//
//  CourseTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Create.h"
#import "Enrollment+Create.h"

static NSString *const CourseTableStoryBoardIdentifier = @"CourseTableViewController";

@protocol CourseTableDelegate <NSObject>

- (void) setEnrollment: (Enrollment*) enrollment;

@end

@interface CourseTableViewController : UITableViewController

@property (nonatomic, strong) id<CourseTableDelegate> delegate;
@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) NSArray *enrollments;

@end
