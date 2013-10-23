//
//  ObjectVerifyer.m
//  TestBlocks
//
//  Created by Daniel Hallin on 2013-10-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AttributeInput.h"

@implementation AttributeInput

#pragma mark - Constructors

- (id) initWithKey:(NSString *)key verifyblock:(verifyBlock)verifyer formatblock:(formatBlock)formatter
{
    if (self = [super init])
    {
        _attributeKey = key;
        _verifyer = verifyer;
        _formatter = formatter;
    }
    return self;
}

#pragma mark - AttributeInput methods

- (bool) verifyString:(NSString *)string errorMessage:(NSString *__autoreleasing *)error
{
    return _verifyer(string, error);
}

- (NSString*) formatString:(NSString *)string
{
    return _formatter(string);
}

#pragma mark - Setters and Getters

@synthesize attributeKey = _attributeKey;

#pragma mark - Verifyers

+ (verifyBlock) nameVerifyer
{
    return ^ bool (NSString* stringToVerify, NSString** error)
    {
        if (!stringToVerify || stringToVerify.length)
        {
            *error = @"Namn kan inte vara tomt";
            return NO;
        }
        return YES;
    };
}

+ (verifyBlock) emailVerifyer
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

+ (verifyBlock) numberVerifyer
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
