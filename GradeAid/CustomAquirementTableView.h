//
//  CustomAquirementTableView.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDelegate.h"
#import "Course+Create.h"
#import "CourseEdition+Create.h"
#import "TeacherAquirementDescription+Create.h"

@interface CustomAquirementTableView : UITableView<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) id<TableViewDelegate> tableViewDelegate;
@property (nonatomic) bool inEditMode;

- (void) selectForEditing: (TeacherAquirementDescription*) teacherAquirementDescription;

- (CGFloat) height;


@end
