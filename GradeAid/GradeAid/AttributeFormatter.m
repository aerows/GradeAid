//
//  AttributeFormatter.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AttributeFormatter.h"

@implementation AttributeFormatter

+ (attributeFormatter) nameFormatter
{
    return ^ NSString* (NSString* stringToFormate)
    {
        return stringToFormate;
    };
}
+ (attributeFormatter) numberFormatter
{
    return ^ NSString* (NSString* stringToFormate)
    {
        return stringToFormate;
    };
}
+ (attributeFormatter) emailFormatter
{
    return ^ NSString* (NSString* stringToFormate)
    {
        return stringToFormate;
    };
}
@end
