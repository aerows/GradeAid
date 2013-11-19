//
//  SchoolClassViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterObjectViewController.h"
#import "SchoolClass+Create.h"

@interface SchoolClassViewController : UIViewController<UITableViewDataSource>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UILabel *_titleLabel;
}

@property (nonatomic) bool inEditMode;

@property (nonatomic, strong) NSArray *attributes;

@property (nonatomic, strong) SchoolClass *schoolClass;
@property (nonatomic, strong) School *selectedSchool;

@end