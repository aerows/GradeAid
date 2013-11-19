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

static NSString *const AquirementCellCellIdentifier = @"AquirementCellIdentifier";

@interface AquirementCell : UITableViewCell<AquirementButtonDelegate>

+ (CGFloat) heightForCellWithAquirement: (Aquirement*) aquirement;
@property (nonatomic, strong) Aquirement *aquirement;

@end
