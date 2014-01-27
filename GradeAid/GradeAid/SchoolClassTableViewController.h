//
//  SchoolClassTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolClass+Create.h"
#import "Course+Create.h"

@interface SchoolClassTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *schoolClasses;
@property (nonatomic, strong) Course *course;
@end
