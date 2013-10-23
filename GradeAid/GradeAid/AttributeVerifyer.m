//
//  AttributeVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-03.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AttributeVerifyer.h"

@implementation AttributeVerifyer
{
    id<AttributeVerifyerDelegate> _delegate;
    id<AttributeVerifyerView> _attributeView;
    
    bool _attributeVerified;
    NSString *_attributeName;
    StringFormatter *_formatter;
    UITextField *_textField;
    NSMutableArray *_stringQriteria;
}

#pragma - Constructor Methods

- (id) initWithAttributeName:(NSString *)attributeName stringFormatter:(StringFormatter *)formatter stringQriteria:(NSArray *)qriteria
{
    if (self = [super init])
    {
        _attributeName = attributeName;
        _formatter = formatter;
        _stringQriteria = [[NSMutableArray alloc] initWithArray: qriteria];
    }
    return self;
}

- (id) init
{
    if (self = [super init])
    {
        _stringQriteria = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma - Public Methods

- (NSString*) unfullfilledQriterium
{
    for (StringQriterium *sq in _stringQriteria)
    {
        if (![sq checkText: _attributeValue])
        {
            return sq.qriterium;
        }
    }
    return @"";
}

- (void) formatAttributeValue
{
    _attributeValue = [_formatter formatString: _textField.text];
    [_textField setText: _attributeValue];
}

#pragma - Private Methods

- (void) verifyAttribute
{
    BOOL verified = YES;
    for (StringQriterium *sq in _stringQriteria)
    {
        verified &= [sq checkText: _attributeValue];
    }
    
    if (_attributeVerified == verified) return;
    
    _attributeVerified = verified;
    [_delegate attributeVerifyerDidUpdate: self];
    [_attributeView attributeVerifyerDidUpdate: self];
}

#pragma - UITextField Delegate Methods

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _attributeValue = [textField.text stringByReplacingCharactersInRange: range withString: string];
    [self verifyAttribute];
    
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [self formatAttributeValue];
}

#pragma - Setters and Getters

@synthesize delegate = _delegate;
@synthesize attributeView = _attributeView;

@synthesize attributeValue = _attributeValue;
@synthesize attributeKey   = _attributeKey;

@synthesize attributeVerified = _attributeVerified;
@synthesize attributeName = _attributeName;
@synthesize formatter = _formatter;
@synthesize textField = _textField;

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
    _textField.delegate = self;
}

- (void) addStringQriterium:(StringQriterium *)qriterium
{
    if (qriterium)
    {
        [_stringQriteria addObject: qriterium];
    }
}

- (void) addStringQriteria:(NSArray *)qriteria
{
    for (StringQriterium *sq in qriteria)
    {
        [_stringQriteria addObject: sq];
    }
}

@end
