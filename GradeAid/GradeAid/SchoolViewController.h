//
//  SchoolViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "School.h"

@interface SchoolViewController : CoreDataTableViewController <ObjectVerifyerDelegate>
@property (nonatomic, strong) School * school;

@end
