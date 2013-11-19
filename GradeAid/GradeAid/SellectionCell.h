//
//  SellectionCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellectionVerifyer.h"

static NSString *const SellectionCellIdentifier = @"SellectionCellIdentifier";

@interface SellectionCell : UITableViewCell<SellectionVerifyerView>
{
    IBOutlet UIImageView *_thumbnailView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UIButton *_sellectionButton;
}

@property (nonatomic, strong) SellectionVerifyer *sellectionVerifyer;


@end
