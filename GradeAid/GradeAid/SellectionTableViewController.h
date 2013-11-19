//
//  SellectionTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellectionViewController.h"

@interface SellectionTableViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) SellectionVerifyer *sellectionVerifyer;

- (CGSize) sizeForNumberOfObjects: (NSInteger) nrOfObjects;

@end