//
//  PopupTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const PopupTableViewControllerCellIdentifier = @"PopupTableViewControllerCellIdentifier";

@interface PopupTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, copy) void(^setupCellWithObject)(UITableViewCell*, NSManagedObject*);
@property (nonatomic, copy) void(^onSelectObject)(NSManagedObject*);
@property (nonatomic) bool clearOnSelection;

@end
