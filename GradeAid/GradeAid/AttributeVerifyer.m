//
//  AttributeVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AttributeVerifyer.h"

@implementation AttributeVerifyer

+ (attributeVerifyer) nameVerifyer
{
    return ^ bool (NSString* stringToVerify, NSString** error)
    {
        if (!stringToVerify || !stringToVerify.length)
        {
            *error = @"Namn kan inte vara tomt";
            return NO;
        }
        return YES;
    };
}

+ (attributeVerifyer) emailVerifyer
{
    return ^ bool (NSString* stringToVerify, NSString** error)
    {
        if (!stringToVerify || stringToVerify.length)
        {
            *error = @"Email kan inte vara tom";
            return NO;
        }
        return YES;
    };
}

static NSString *const allowedCharactersInNumber = @"+-0123456789 ";

+ (attributeVerifyer) numberVerifyer
{
    return ^ bool (NSString* stringToVerify, NSString** error)
    {
        if (!stringToVerify || stringToVerify.length)
        {
            *error = @"Numret kan inte vara tomt";
            return NO;
        }
        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString: allowedCharactersInNumber] invertedSet];
        
        if (![stringToVerify rangeOfCharacterFromSet: set].length)
        {
            *error = @"Nummer får bara innehålla +, - och 0-9.";
            return NO;
        }
        return YES;
    };
}


@end
