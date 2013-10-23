//
//  ObjectVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-08.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "ObjectVerifyer.h"
#import "AppDelegate.h"

@implementation ObjectVerifyer
{
    NSMutableArray *_attributeVerifyers;
}

#pragma - Constructor Methods

- (id) init
{
    if (self = [super init])
    {
        _attributeVerifyers = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma - ObjectVerifyer Methods

- (void) saveObject
{
    if (!_objectVerified) return;
    
    for (AttributeVerifyer *av in _attributeVerifyers)
    {
        [av formatAttributeValue];
    }
    id object = [self _saveObject];
    [[AppDelegate sharedDelegate] saveContext];

    [_delegate objectVerifyer: self createdObject: object];
}

- (id) _saveObject
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

#pragma - AttributeVerifyer Delegate Methods

- (void) attributeVerifyerDidUpdate:(id)sender
{
    AttributeVerifyer *av = (AttributeVerifyer*) sender;
    bool allAttributesVerified = YES;
    if (!av.isAttributeVerified)
    {
        allAttributesVerified = NO;
    }
    else
    {
        for (AttributeVerifyer *a in _attributeVerifyers)
        {
            allAttributesVerified &= a.isAttributeVerified;
        }
    }
    [self _setObjectVerified: allAttributesVerified];
}

- (void) _setObjectVerified:(bool)objectVerified
{
    if (_objectVerified == objectVerified) return;
    
    _objectVerified = objectVerified;
    [_view objectVerifyerDidUpdate: self];
}

#pragma - Getters and Setters

@synthesize view = _view;
@synthesize delegate = _delegate;

@synthesize createMany = _createMany;

@synthesize createObjectTitle = _createObjectTitle;
@synthesize objectVerified = _objectVerified;
@synthesize defaultImage = _defaultImage;
@synthesize attributeVerifyers = _attributeVerifyers;

- (void) addAttributeVerifyer:(AttributeVerifyer *)attributeVerifyer
{
    if (attributeVerifyer)
    {
        [attributeVerifyer setDelegate: self];
        [_attributeVerifyers addObject: attributeVerifyer];
    }
}

- (void) addAttributeVerifyers:(NSArray *)attributeVerifyers
{
    for (AttributeVerifyer *av in attributeVerifyers)
    {
        [self addAttributeVerifyer: av];
    }
}

@end
