//
//  StringQriteriumRestrictedCharacters.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "StringQriteriumRestrictedCharacters.h"

@implementation StringQriteriumRestrictedCharacters
{
    NSCharacterSet *_characters;
}

- (id) initWithCharacterSet:(NSCharacterSet *)set
{
    if (self = [super init])
    {
        _characters = set;
    }
    return self;
}
- (bool) checkText:(NSString *)text
{
    return [[text stringByTrimmingCharactersInSet:_characters] isEqualToString:@""];
}

- (NSString*) qriterium
{
    return nil;
}


@end

