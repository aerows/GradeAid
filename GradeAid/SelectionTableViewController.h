//
//  SelectionTableViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SelectionTableViewControllerCellIdentifier = @"SelectionTableViewControllerCellIdentifier";

enum SelectionStyle
{
    SingleSelectionStyle = 0,
    MultiSelectionStyle  = 1
};

@interface SelectionTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_selectedObjects;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) NSArray *selectedObjects;

@property (nonatomic) enum SelectionStyle selectionStyle;

@property (nonatomic, copy) void(^setupCellWithObject)(UITableViewCell*, NSManagedObject*);
@property (nonatomic, copy) void(^onDone)(NSArray*);
@property (nonatomic, copy) bool(^areEqual)(NSManagedObject*, NSManagedObject*);

@end
