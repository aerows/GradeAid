//
//  StudentViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student+Create.h"

@interface StudentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *_titleLabel;
}

@property (nonatomic, weak) IBOutlet UITableView *studentTableView;

@property (nonatomic, strong) Student *student;
@property (nonatomic) bool inEditMode;

@property (nonatomic, strong) NSArray *attributeInputs;

@property (nonatomic, strong) SchoolClass *selectedSchoolClass;

@end
