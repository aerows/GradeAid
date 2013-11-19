//
//  PopupCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-08.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const PopupCellIdentifier = @"PopupCellIdentifier";

@interface PopupCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *thumbNail;
@property (nonatomic, strong) NSString *title;

@end
