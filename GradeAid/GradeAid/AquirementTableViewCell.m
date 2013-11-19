//
//  AquirementTableViewCell.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AquirementTableViewCell.h"

@implementation AquirementTableViewCell

#pragma mark - Getters and Setters

@synthesize aquirementDescription = _aquirementDescription;

- (void) setAquirementDescription:(AquirementDescription *)aquirementDescription
{
    _aquirementDescription = aquirementDescription;
    [textView setText: _aquirementDescription.caption];
}

@end
