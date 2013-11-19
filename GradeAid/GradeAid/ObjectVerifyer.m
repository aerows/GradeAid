//
//  ObjectVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "ObjectVerifyer.h"


@implementation ObjectVerifyer

- (id) initWithAttributes:(NSDictionary *)attributes orderedKeys:(NSArray *)attributeKeys sellectors:(NSDictionary *)sellectors sellectorKeys:(NSArray *)selectorKeys completion:(void (^)(NSDictionary *, NSManagedObjectContext *))completion
{
    if (self = [super init])
    {
        [self setAttributeInputs: attributes];
        _orderedAttributeKeys = attributeKeys;

        [self setAttributeSellectionInputs: sellectors];
        _orderedSelectorKeys = selectorKeys;
        
        _completion = completion;
    }
    return self;
}


- (id) initWithAttributes: (NSDictionary*) attributes orderedKeys:(NSArray *)keys completion:(void (^)(NSDictionary *, NSManagedObjectContext *))completion
{
    if (self = [super init])
    {
        self.attributeInputs = attributes;
        _completion = completion;
        _orderedAttributeKeys = keys;
    }
    return self;
}

- (void) update
{
    bool allInputsVerified = YES;
    for (NSString *key in _attributeInputs.allKeys)
    {
        allInputsVerified &= [[_attributeInputs objectForKey: key] isVerified];
    }
    
    if (_objectVerified == allInputsVerified) return;
    
    _objectVerified = allInputsVerified;
    [_view updateView];
}

- (void) createInManagedObjectContext: (NSManagedObjectContext*) moc
{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    for (NSString *key in _attributeInputs.allKeys)
    {
        [attributes setObject: [(AttributeInput*)[_attributeInputs objectForKey: key] value] forKey: key];
    }
    for (NSString *key in _attributeSellectionInputs.allKeys)
    {
        id object = [(SellectionVerifyer*)[_attributeSellectionInputs objectForKey: key] value];
        if (object) [attributes setObject: object forKey: key];
    }
    
    _completion(attributes, moc);

    NSError *error = nil;
    [moc save: &error];
    if (error)
    {
        NSLog(@"%@", error.localizedDescription);
    }
}

#pragma mark - Getters and Setters

@synthesize attributeInputs = _attributeInputs;
@synthesize attributeSellectionInputs = _attributeSellectionInputs;

@synthesize orderedAttributeKeys = _orderedAttributeKeys;
@synthesize orderedSelectorKeys = _orderedSelectorKeys;

@synthesize objectVerified = _objectVerified;
@synthesize view = _view;


- (void) setAttributeInputs:(NSDictionary *)attributeInputs
{
    for (NSString *key in attributeInputs.allKeys)
    {
        [[attributeInputs objectForKey: key] setDelegate: self];
    }
        
    _attributeInputs = attributeInputs;
}

- (void) setAttributeSellectionInputs:(NSDictionary *)attributeSellectionInputs
{
    for (NSString *key in attributeSellectionInputs.allKeys)
    {
        [[attributeSellectionInputs objectForKey: key] setDelegate: self];
    }
    
    _attributeSellectionInputs = attributeSellectionInputs;
}



@end
