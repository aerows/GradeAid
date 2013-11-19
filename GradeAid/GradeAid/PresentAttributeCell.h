//
//  PresentAttributeCell.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributeInput.h"

static NSString *const PresentAttributeCellIdentifier = @"PresentAttributeCellIdentifier";

@interface PresentAttributeCell : UITableViewCell
{
    IBOutlet UILabel     *_attributeValueLabel;
    IBOutlet UILabel     *_attributeTitleLabel;
}

@property (nonatomic, strong) AttributeInput *attributeInput;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

@end
