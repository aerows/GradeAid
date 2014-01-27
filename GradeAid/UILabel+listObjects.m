//
//  UILabel+listObjects.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-10.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "UILabel+listObjects.h"

@implementation UILabel (listObjects)

- (void) listObjects:(NSArray *)stringArray lineBreak:(bool)lineBreak
{
    if (!stringArray.count)
    {
        [self setText: @""];
        return;
    }
    NSMutableString *string = [[NSMutableString alloc] init];
    NSString *separator = (lineBreak) ? @",\n" : @", ";
    
    for (NSString *s in stringArray)
    {
        [string appendString: [NSString stringWithFormat: @"%@%@", s, separator]];
    }
    NSRange rangeOfLastSeparator = NSMakeRange(string.length - separator.length, separator.length);
    [string deleteCharactersInRange: rangeOfLastSeparator];
    
    if ([self textFitsLabel: string])
    {
        [self setText: string];
        return;
    }
    
    NSString *tail = [NSString stringWithFormat: @"...(%d)", stringArray.count];

    while (![self textFitsLabel: [NSString stringWithFormat: @"%@%@", string, tail]])
    {
        NSRange lastCharRange = NSMakeRange(string.length - 1, 1);
        [string deleteCharactersInRange: lastCharRange];
    }
    [self setText: [NSString stringWithFormat: @"%@%@", string, tail]];
}

- (bool) textFitsLabel: (NSString*) text
{
    CGSize size = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    UIFont *font = self.font;
    NSLineBreakMode mode = self.lineBreakMode;
    return [text sizeWithFont: font
            constrainedToSize: size
                lineBreakMode: mode].height < self.frame.size.height;
}

@end
