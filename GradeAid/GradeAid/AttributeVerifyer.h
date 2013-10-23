//
//  AttributeVerifyer.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringQriterium.h"
#import "StringFormatter.h"

@protocol AttributeVerifyerView <NSObject>

- (void) attributeVerifyerDidUpdate: (id) sender;

@end

@protocol AttributeVerifyerDelegate <NSObject>

- (void) attributeVerifyerDidUpdate: (id) sender;

@end

@interface AttributeVerifyer : NSObject <UITextFieldDelegate>

- (id) initWithAttributeName: (NSString*) attributeName stringFormatter: (StringFormatter*) formatter stringQriteria: (NSArray*) qriteria;

- (NSString*) unfullfilledQriterium;
- (void) formatAttributeValue;

@property (nonatomic, strong) NSString* attributeValue;
@property (nonatomic, strong) NSString* attributeKey;

@property (nonatomic, getter = isAttributeVerified) bool attributeVerified;
@property (nonatomic, strong) NSString *attributeName;
@property (nonatomic, strong) StringFormatter *formatter;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) id<AttributeVerifyerView> attributeView;
@property (nonatomic, strong) id<AttributeVerifyerDelegate> delegate;

- (void) addStringQriterium: (StringQriterium*) qriterium;
- (void) addStringQriteria: (NSArray *) qriteria;

@end
