//
//  ObjectVerifyer.h
//  TestBlocks
//
//  Created by Daniel Hallin on 2013-10-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef bool (^verifyBlock)(NSString*, NSString**);
typedef NSString* (^formatBlock)(NSString*);

@interface AttributeInput : NSObject
{
    verifyBlock _verifyer;
    formatBlock _formatter;
}

- (id) initWithKey: (NSString*) key verifyblock: (verifyBlock) verifyer formatblock: (formatBlock) formatter;

- (bool) verifyString: (NSString*) string errorMessage: (NSString**) error;
- (NSString*) formatString: (NSString*) string;

@property (nonatomic, strong) NSString *attributeKey;

+ (verifyBlock) nameVerifyer;
+ (verifyBlock) emailVerifyer;
+ (verifyBlock) numberVerifyer;

+ (formatBlock) nameFormatter;
+ (formatBlock) numberFormatter;
+ (formatBlock) emailFormatter;


@end
