//
//  SchoolViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School+Create.h"


@interface SchoolViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UILabel *_titleLabel;
}

// global

@property (nonatomic) bool inEditMode;

@property (nonatomic, strong) School *school;


@end
