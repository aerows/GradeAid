//
//  CentralContentTableViewCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseCentralContent+Create.h"

static NSString *const CentralContentTableViewCellIdentifier = @"CentralContentTableViewCellIdentifier";

@interface CentralContentTableViewCell : UITableViewCell
{
    IBOutlet UILabel *centralContentLabel;
}

@property (nonatomic, strong) CourseCentralContent *centralContent;

@end
