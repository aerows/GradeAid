//
//  UIStoryboard+mainStoryboard.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "UIStoryboard+mainStoryboard.h"

@implementation UIStoryboard (mainStoryboard)

+ (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
}

@end