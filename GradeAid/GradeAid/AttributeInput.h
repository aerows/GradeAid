//
//  ObjectVerifyer.h
//  TestBlocks
//
//  Created by Daniel Hallin on 2013-10-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeVerifyer.h"
#import "AttributeFormatter.h"

@protocol AttributeInputDelegate <NSObject>

- (void) update;

@end

@protocol AttributeInputView <NSObject>

- (void) updateView;

@end

@interface AttributeInput : NSObject<UITextFieldDelegate>
{
    attributeVerifyer  _verifyer;
    attributeFormatter _formatter;
}

- (id) initWithVerifyer: (attributeVerifyer) verifyer formatter: (attributeFormatter) formatter;

- (bool) updateObject: (NSManagedObject*) object;

@property (nonatomic, strong) NSString* attributeTitle;
@property (nonatomic, strong) NSString* attributeExample;
@property (nonatomic, strong) NSString* key;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) id<AttributeInputView> view;
@property (nonatomic, strong) id<AttributeInputDelegate> delegate;

@property (nonatomic, readonly, getter = isVerified) bool verified;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong, readonly) NSString* errorMsg;

+ (AttributeInput*) nameAttribute;

@end
