//
//  CourseCollectionViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+Create.h"

static NSString *const CourseCollectionViewCellIdentifier = @"CourseCollectionViewCellIdentifier";

@interface CourseCollectionViewCell : UICollectionViewCell
{
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_descriptionLabel;
    IBOutlet UILabel *_classesLabel;
    IBOutlet UILabel *_studentsLabel;
}

@property (nonatomic, strong) Course *course;

@end
