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

- (id) initWithVerifyer:(attributeVerifyer)verifyer formatter:(attributeFormatter)formatter
{
    if (self = [super init])
    {
        _verifyer = verifyer;
        _formatter = formatter;
    }
    return self;
}

#pragma mark - TextField Delegate Methods

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    _value = _formatter(_value);
    textField.text = _value;
}

- (void) textFieldDidChange: (id) sender
{
    _value = _textField.text;
    
    NSString *errorMsg = nil;
    bool verified = _verifyer(_value, &errorMsg);
    
    if (_verified == verified && [errorMsg isEqualToString: _errorMsg]) return;
    
    _verified = verified;
    errorMsg = errorMsg;

    [_view updateView];
    [_delegate update];
}

#pragma mark - AttributeInput Methods

- (bool) verifyString:(NSString *)string errorMessage:(NSString *__autoreleasing *)error
{
    return _verifyer(string, error);
}

- (NSString*) formatString:(NSString *)string
{
    return _formatter(string);
}

#pragma mark - Class Methods

+ (AttributeInput*) nameAttribute
{
    return [[AttributeInput alloc] initWithVerifyer: [AttributeVerifyer nameVerifyer] formatter: [AttributeFormatter nameFormatter]];
}

#pragma mark - Getters and Setters

@synthesize attributeTitle = _attributeTitle;
@synthesize attributeExample = _attributeExample;

@synthesize verified = _verified;
@synthesize errorMsg = _errorMsg;
@synthesize value = _value;

@synthesize key = _key;
@synthesize textField = _textField;
@synthesize view = _view;
@synthesize delegate = _delegate;

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
    [_textField removeTarget: nil action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField.delegate = nil;
    
    _textField.text = _value;
    _textField.placeholder = _attributeExample;
    
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

@end
