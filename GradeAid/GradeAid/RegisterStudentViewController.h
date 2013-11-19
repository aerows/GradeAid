//
//  RegisterStudentViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterObjectViewController.h"
#import "Student+Create.h"
#import "School.h"
#import "SchoolClass.h"


@interface RegisterStudentViewController : RegisterObjectViewController<UITableViewDataSource, UITableViewDelegate, SellectionVerifyerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *studentTableView;

@property (nonatomic, strong) Student *student;
@property (nonatomic) bool inEditMode;

@property (nonatomic, strong) NSArray *attributeInputs;
@property (nonatomic, strong) NSArray *attributeSelectors;

@property (nonatomic, strong) School *selectedSchool;
@property (nonatomic, strong) SchoolClass *selectedSchoolClass;

@end
