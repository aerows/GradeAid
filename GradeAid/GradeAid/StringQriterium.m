//
//  StringQriterium.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "StringQriterium.h"
#import "StringQriteriumRestrictedCharacters.h"
#import "StringQriteriumRestrictedLength.h"

@implementation StringQriterium
{
    id<StringQriteriumProtocol> _stringQriterium;
}

- (id) initWithStringQriterium: (id<StringQriteriumProtocol>) stringQriterium
{
    if (self = [super init])
    {
        _stringQriterium = stringQriterium;
    }
    return self;
}

- (bool) checkText:(NSString *)text
{
    return [_stringQriterium checkText: text];
}

- (NSString*) qriterium
{
    return [_stringQriterium qriterium];
}

#pragma - StringQriteria

+ (StringQriterium*) notEmtpyQriterium
{
    NSRange notEmtpyRange = NSMakeRange(1, NSIntegerMax);
    NSString *caption = @"Field can not be empty";
    id<StringQriteriumProtocol> stringQriterium  = [[StringQriteriumRestrictedLength alloc] initWithRange: notEmtpyRange
                                                                                         qriteriumCaption: caption];
    return [[StringQriterium alloc] initWithStringQriterium: stringQriterium];
}

+ (StringQriterium*) restrictedCharactersQriterium:(NSCharacterSet *)characters
{
    id<StringQriteriumProtocol> sqrc = [[StringQriteriumRestrictedCharacters alloc] initWithCharacterSet: characters];
    return [[StringQriterium alloc] initWithStringQriterium: sqrc];
}

@end
