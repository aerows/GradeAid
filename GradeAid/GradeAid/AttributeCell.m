 //
//  AttributeCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-04.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AttributeCell.h"
#import "Label.h"

@implementation AttributeCell
{
    IBOutlet Label *warningLabel;
}

#pragma - Constructor Methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    // Kan tas bort
    self = [super initWithCoder:aDecoder];
    return self;
}

#pragma - AttributeVerifyer View Methods

- (void) attributeVerifyerDidUpdate:(id)sender
{
    [warningLabel setText: (_attributeVerifyer.isAttributeVerified) ? @"" : _attributeVerifyer.unfullfilledQriterium];
}

#pragma - Getters and Setters

- (void) setAttributeVerifyer:(AttributeVerifyer *)attributeVerifyer
{
    _attributeVerifyer = attributeVerifyer;
    [_attributeVerifyer setAttributeView: self];
    [_attributeVerifyer setTextField: _textField];
    [_textField setPlaceholder: _attributeVerifyer.attributeName];
    [_textField setText: _attributeVerifyer.attributeValue];
}

@synthesize textField = _textField;
@synthesize attributeVerifyer = _attributeVerifyer;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
