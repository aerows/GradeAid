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

@interface TeacherAquirementCell : UITableViewCell
{
    UITapGestureRecognizer *_tapper;
}

@property (nonatomic, strong) TeacherAquirement *teacherAquirement;

@end
