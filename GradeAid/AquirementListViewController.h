//
//  AquirementListViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enrollment+Create.h"

@interface AquirementListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    IBOutlet UITableView *_aquirementTableView;
    IBOutlet UILabel *_noAquirementDescriptionsLabel;
}

// State
@property (nonatomic) bool inEditMode;

// Model
@property (nonatomic, strong) Enrollment *enrollment;

// View
@property (nonatomic, strong) UITableView *aquirementTableView;
@property (nonatomic, strong) UILabel *noAquirementDescriptionsLabel;

@end
