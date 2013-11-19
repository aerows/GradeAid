//
//  SubjectiveObjectiveHeaderTableViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectiveObjectiveHeaderTableViewCell.h"

@implementation SubjectiveObjectiveHeaderTableViewCell

#pragma mark - Getters and Setters

@synthesize title = _title;

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_headerLabel setText: [NSString stringWithFormat: @"%@:", _title]];
}

@end
