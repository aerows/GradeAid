//
//  PopupCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-08.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "PopupCell.h"

@implementation PopupCell
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel *_titleLabel;
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

- (void) setThumbNail:(UIImage *)thumbNail
{
    _thumbNail = thumbNail;
    [_imageView setImage: _thumbNail];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText: _title];
}

@end
