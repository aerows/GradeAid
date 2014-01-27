//
//  CustomAquirementListViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAquirementTableView.h"

@interface CustomAquirementListViewController : UIViewController<TableViewDelegate>
{
    IBOutlet CustomAquirementTableView *_customAquirementTableView;
    IBOutlet UILabel *_aquirementDescriptionLabel;
    IBOutlet UIButton *_addAquirementDescriptionButton;
    IBOutlet UILabel *_noAquirementDescriptionsLabel;
}

// State
@property (nonatomic) bool inEditMode;

// Model
@property (nonatomic, strong) Course *course;

// View
@property (nonatomic, strong) CustomAquirementTableView *customAquirementTableView;
@property (nonatomic, strong) UILabel *aquirementDescriptionLabel;
@property (nonatomic, strong) UIButton *addAquirementDescriptionButton;
@property (nonatomic, strong) UILabel *noAquirementDescriptionsLabel;

@end