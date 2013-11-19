//
//  SubjectObjectiveTableViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectObjectiveTableViewCell.h"

@implementation SubjectObjectiveTableViewCell

#pragma mark - Getters and Setters

@synthesize objective = _objective;
@synthesize title = _title;

- (void) setObjective:(SubjectObjective *)objective
{
    _objective = objective;
    [_objetiveLabel setText: objective.caption];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_objetiveLabel setText: _title];
}

@end
