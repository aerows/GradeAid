//
//  SubjectTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-27.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject+Create.h"
#import "TableViewDelegate.h"


@interface SubjectTableView : UITableView<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Subject *subject;
@property (nonatomic, strong) id<TableViewDelegate> tableViewDelegate;

- (CGFloat) height;

@end
