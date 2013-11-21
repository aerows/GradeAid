//
//  ExpandableHeaderCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const ExpandableHeaderCellIdentifier = @"ExpandableHeaderCellIdentifier";

@interface ExpandableHeaderCell : UITableViewCell
{
    IBOutlet UILabel *_expandLabel;
}

@property (nonatomic, strong) UILabel *expandLabel;

@end
