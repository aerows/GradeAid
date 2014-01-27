//
//  TeacherAquirementViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enrollment+Create.h"

@interface TeacherAquirementViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    IBOutlet UITableView *_teacherAquirementTableView;
    IBOutlet UILabel *_noAquirementDescriptionsLabel;
}

// State
@property (nonatomic) bool inEditMode;

// Model
@property (nonatomic, strong) Enrollment *enrollment;

// View
@property (nonatomic, strong) UITableView *teacherAquirementTableView;
@property (nonatomic, strong) UILabel *noAquirementDescriptionsLabel;

@end
