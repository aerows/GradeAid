//
//  StringFormatter.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "StringFormatter.h"
#import "NameFormatter.h"

@implementation StringFormatter
{
    id<StringFormatterProtocol> _stringFormater;
}

- (id) initWithStringFormatter:(id<StringFormatterProtocol>)formatter
{
    if (self = [super init])
    {
        _stringFormater = formatter;
    }
    return self;
}

- (NSString*) formatString:(NSString *)stringToFormat
{
    return [_stringFormater formatString: stringToFormat];
}

#pragma formatters

+ (StringFormatter*) nameFormatter
{
    NameFormatter *nf = [[NameFormatter alloc] init];
    StringFormatter *sf = [[StringFormatter alloc] initWithStringFormatter: nf];
    return sf;
}

@end
