//
//  TeacherAquirementEditCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherAquirementDescription+Create.h"

static NSString *const TeacherAquirementEditCellIdentifier = @"TeacherAquirementEditCellIdentifier";

@interface TeacherAquirementDescriptionEditCell : UITableViewCell <UITextFieldDelegate>
{
    IBOutlet UITextField *_textField;
}

@property (nonatomic, strong) TeacherAquirementDescription *teacherAquirementDescription;
@property (nonatomic, strong) UITextField *textField;

@end
