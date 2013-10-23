//
//  ObjectVerifyer.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-08.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeVerifyer.h"

@protocol ObjectVerifyerView <NSObject>

- (void) objectVerifyerDidUpdate: (id) sender;

@end

@protocol ObjectVerifyerDelegate <NSObject>

- (void) objectVerifyer: (id) sender createdObject: (id) object;

@end

@interface ObjectVerifyer : NSObject<AttributeVerifyerDelegate>

@property (nonatomic, strong) id object;

@property (nonatomic) bool createMany;
@property (nonatomic, strong) NSString *createObjectTitle;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) NSArray *attributeVerifyers;
@property (nonatomic, getter = isObjectVerified) bool objectVerified;

@property (nonatomic, strong) id<ObjectVerifyerView> view;
@property (nonatomic, strong) id<ObjectVerifyerDelegate> delegate;

- (void) addAttributeVerifyer: (AttributeVerifyer*) attributeVerifyer;
- (void) addAttributeVerifyers: (NSArray*) attributeVerifyers;

- (void) saveObject;
- (id) _saveObject;
@end

@protocol ObjectWithVerifyer <NSObject>

+ (ObjectVerifyer*) objectVerifyer;
+ (UIImage*) defaultImage;

@end