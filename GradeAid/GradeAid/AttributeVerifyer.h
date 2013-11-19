//
//  AttributeVerifyer.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef bool (^attributeVerifyer)(NSString*, NSString**);

@interface AttributeVerifyer : NSObject

+ (attributeVerifyer) nameVerifyer;
+ (attributeVerifyer) emailVerifyer;
+ (attributeVerifyer) numberVerifyer;

@end
