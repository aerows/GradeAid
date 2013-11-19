//
//  SettingsCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-01.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SettingsCellIdentifier = @"SettingsCellIdentifier";

@interface SettingsCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *thumbNail;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *number;

@end
