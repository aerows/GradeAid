//
//  RegisterCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

static NSString *const VerifiedImage = @"check";
static NSString *const NotVerifiedImage = @"cross";

#import "AttributeCell.h"

@implementation AttributeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) updateView
{
    NSString *imageName = (_attributeInput.isVerified) ? VerifiedImage : NotVerifiedImage;
    [_imageView setImage: [UIImage imageNamed: imageName]];
}

#pragma mark - Getters and Setters

@synthesize attributeInput = _attributeInput;

- (void) setAttributeInput:(AttributeInput *)attributeInput
{
    _attributeInput = attributeInput;
    [_attributeInput setView: self];
    [_attributeInput setTextField: _textField];
    [_attributeTitleLabel setText: _attributeInput.attributeTitle];
    
    
}

@end
