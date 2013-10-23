//
//  StringQriteriumNotEmpty.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-02.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "StringQriteriumRestrictedLength.h"

@implementation StringQriteriumRestrictedLength
{
    NSRange _range;
    NSString *_caption;
}

- (id) initWithRange:(NSRange)range qriteriumCaption:(NSString *)caption
{
    if (self = [super init])
    {
        _range = range;
        _caption = caption;
    }
    return self;
}
- (bool) checkText:(NSString *)text
{
    return NSLocationInRange(text.length, _range);
}

- (NSString*) qriterium
{
    return _caption;
}

@end
