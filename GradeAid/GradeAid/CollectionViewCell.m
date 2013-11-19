//
//  SchoolCollectionViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Label.h"

@implementation CollectionViewCell
{
    IBOutlet UIImageView *imageView;
    IBOutlet Label *titleLabel;
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
@synthesize image = _image;

- (void) setTitle:(NSString *)title
{
    _title = title;
    [titleLabel setText: _title];
}

- (void) setImage:(UIImage *)image
{
    _image = image;
    [imageView setImage: _image];
}

@end
