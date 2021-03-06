//
//  CourseDescriptionCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseEdition+Create.h"

static NSString *const CourseEditionCellIdentifier = @"CourseEditionCellIdentifier";

@interface CourseEditionCell : UICollectionViewCell

@property (nonatomic, strong) CourseEdition *courseEdition;

@end
