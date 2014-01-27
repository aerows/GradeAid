//
//  PlusTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-14.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSInteger const createCourseIndex = 0;
static NSInteger const createStudentIndex = 1;
static NSInteger const createSchoolIndex = 2;
static NSInteger const createSchoolClassIndex = 3;
static NSInteger const createCourseDescription = 4;

@protocol PlusButtonDelegate <NSObject>

- (void) plusTableViewController: (id) plusTableViewController plusButtonSelectedIndex: (NSInteger) index;

@end

@interface PlusTableViewController : UITableViewController<UITableViewDelegate>
@property (nonatomic, assign) id<PlusButtonDelegate> delegate;
@end
