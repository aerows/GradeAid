//
//  ExpandableHeaderCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "ExpandableHeaderCell.h"

@implementation ExpandableHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma - Getters and Setters

@synthesize expandLabel = _expandLabel;

@end
