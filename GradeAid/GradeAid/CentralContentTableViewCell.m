//
//  CentralContentTableViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CentralContentTableViewCell.h"

@implementation CentralContentTableViewCell

#pragma mark - Setters and Getters

@synthesize centralContent = _centralContent;

- (void) setCentralContent:(CourseCentralContent *)centralContent
{
    _centralContent = centralContent;
    [centralContentLabel setText: _centralContent.caption];
}

@end
