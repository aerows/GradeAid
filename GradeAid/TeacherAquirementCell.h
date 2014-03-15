//
//  TeacherAquirementCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherAquirement+Create.h"

static NSString *const TeacherAquirementCellIdentifier = @"TeacherAquirementCellIdentifier";
static NSString *const TeacherAquirementCellDidEnableEditNotification = @"TeacherAquirementCellDidEnableEditNotification";
@interface TeacherAquirementCell : UITableViewCell
{
    UITapGestureRecognizer *_tapper;
    UILongPressGestureRecognizer *_presser;
}

@property (nonatomic, strong) TeacherAquirement *teacherAquirement;
@property (nonatomic) bool editmode;
@property (nonatomic) bool shadowed;

@end
