//
//  NameFormatter.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "NameFormatter.h"

@implementation NameFormatter

- (NSString*) formatString:(NSString *)stringToFormat
{
    NSString *formatted = stringToFormat;
    formatted = [formatted capitalizedString];
    formatted = [formatted stringByTrimmingCharactersInSet: [[NSCharacterSet letterCharacterSet] invertedSet]];
    formatted = [formatted stringByReplacingOccurrencesOfString: @"\\s+" withString: @" " options:NSRegularExpressionSearch range: NSMakeRange(0, formatted.length)];
    formatted = [formatted stringByReplacingOccurrencesOfString: @"\\s*-\\s*" withString: @"-" options:NSRegularExpressionSearch range: NSMakeRange(0, formatted.length)];
    return formatted;
}

@end
