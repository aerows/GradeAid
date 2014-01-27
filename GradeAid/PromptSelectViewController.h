//
//  PromptSelectViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptViewController.h"

static NSString *const CreateNewCellIdentifier = @"CreateNewCellIdentifier";
static NSString *const ObjectCellIdentifier = @"ObjectCellIdentifier";

typedef UITableViewCell*(^TableViewCellBlock)(UITableView*, NSIndexPath*);

@interface PromptSelectViewController : PromptViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
}

- (void) createNewButtonPressed;
- (void) reloadObjects;

- (UIImage*) imageForObject: (id) object;
- (NSString*) titleForObject: (id) object;

@property (nonatomic, strong) NSArray *objects;

@property (nonatomic) bool displayPlusOption;
@property (nonatomic, strong) NSString *plusOptionTitle;
@property (nonatomic, copy) DoneSelectingBlock doneSelectingBlock;

@end
