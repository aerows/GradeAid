//
//  CustomAquirementListViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAquirementTableView.h"

@interface CustomAquirementListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_customAquirementTableView;
    IBOutlet UILabel *_aquirementDescriptionLabel;
    IBOutlet UIButton *_addAquirementDescriptionButton;
    IBOutlet UILabel *_noAquirementDescriptionsLabel;

    NSMutableArray *_customAquirements;
}

// State
@property (nonatomic) bool inEditMode;

// Model
@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) NSArray *customAquirements;

// View
@property (nonatomic, strong) UITableView *customAquirementTableView;
@property (nonatomic, strong) UILabel *aquirementDescriptionLabel;
@property (nonatomic, strong) UIButton *addAquirementDescriptionButton;
@property (nonatomic, strong) UILabel *noAquirementDescriptionsLabel;

@end