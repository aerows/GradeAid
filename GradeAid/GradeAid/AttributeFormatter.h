//
//  AttributeFormatter.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^attributeFormatter)(NSString*);

@interface AttributeFormatter : NSObject

+ (attributeFormatter) nameFormatter;
+ (attributeFormatter) numberFormatter;
+ (attributeFormatter) emailFormatter;

@end
