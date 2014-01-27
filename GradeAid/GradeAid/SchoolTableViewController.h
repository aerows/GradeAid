//
//  SchoolTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School+Create.h"
#import "Course+Create.h"

@interface SchoolTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *schools;
@property (nonatomic, strong) Course *course;

@end
