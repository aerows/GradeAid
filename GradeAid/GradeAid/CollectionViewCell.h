//
//  SchoolCollectionViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School.h"

static NSString *const CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";



@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end
