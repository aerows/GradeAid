//
//  PresentAttributeCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "PresentAttributeCell.h"

@implementation PresentAttributeCell

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

#pragma mark - Getters and Setters

@synthesize attributeInput = _attributeInput;
@synthesize title = _title;
@synthesize text = _text;

- (void) setAttributeInput:(AttributeInput *)attributeInput
{
    _attributeInput = attributeInput;
    _attributeTitleLabel.text = _attributeInput.attributeTitle;
    _attributeValueLabel.text = _attributeInput.value;
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    _attributeTitleLabel.text = _title;
}

- (void) setText:(NSString *)text
{
    _text = text;
    _attributeValueLabel.text = _text;
}

@end
