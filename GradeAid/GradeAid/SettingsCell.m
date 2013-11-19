//
//  SettingsCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-01.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_numberLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Getters and Setters

@synthesize title = _title;
@synthesize thumbNail = _thumbNail;
@synthesize number = _number;

- (void) setThumbNail:(UIImage *)thumbNail
{
    _thumbNail = thumbNail;
    [_imageView setImage: _thumbNail];
    [_numberLabel setText: @""];

}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText: _title];
}

- (void) setNumber: (NSNumber*) number
{
    _number = number;
    [_numberLabel setText: [NSString stringWithFormat: @"%@", _number]];
    [_imageView setImage: nil];
}

@end
