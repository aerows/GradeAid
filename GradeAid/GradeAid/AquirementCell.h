//
//  AquirementCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseAquirementDescription+Create.h"
#import "AquirementButton.h"
#import "Aquirement+Manage.h"

static NSString *const AquirementCellDidEnableEditNotification = @"AquirementCellDidEnableEditNotification";

typedef void(^EnableEdit)();

static NSString *const AquirementCellCellIdentifier = @"AquirementCellIdentifier";

@interface AquirementCell : UITableViewCell
{
    UITapGestureRecognizer       *_tapper;
    UILongPressGestureRecognizer *_presser;
}

+ (CGFloat) heightForCellWithAquirement: (Aquirement*) aquirement;
- (void) updateLayout;

@property (nonatomic, strong) Aquirement *aquirement;
@property (nonatomic, strong) NSNumber *grade;
@property (nonatomic) bool editmode;
@property (nonatomic, copy) EnableEdit enableEdit;
@property (nonatomic) bool shadowed;

@end
