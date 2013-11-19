//
//  CourseEditionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-13.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterObjectViewController.h"
#import "CourseEdition+Create.h"
#import "SellectionVerifyer.h"
#import "Subject+Create.h"

@interface CourseEditionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_schoolClasses;
    
    IBOutlet UILabel *_titleLabel;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *schoolClasses;


@property (nonatomic, strong) CourseEdition *courseEdition;
@property (nonatomic) bool inEditMode;

@property (nonatomic, strong) CourseDescription *courseDescription;
@property (nonatomic, strong) Subject *subject;

@end
