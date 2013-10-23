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

@synthesize school = _school;

- (void) setSchool:(School *)school
{
    _school = school;
    [titleLabel setText: school.name];
    [imageView setImage: [school schoolImage]];
}

@end
