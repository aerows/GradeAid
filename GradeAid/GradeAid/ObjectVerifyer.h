//
//  ObjectVerifyer.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-30.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeInput.h"
#import "SellectionVerifyer.h"

@protocol ObjectVerifyerView <NSObject>

- (void) updateView;

@end


@interface ObjectVerifyer : NSObject<AttributeInputDelegate>
{
    void (^_completion)(NSDictionary*, NSManagedObjectContext*);
}

- (id) initWithAttributes: (NSDictionary*) attributes orderedKeys: (NSArray*) attributeKeys completion: (void (^)(NSDictionary*, NSManagedObjectContext*)) completion;

- (id) initWithAttributes: (NSDictionary*) attributes orderedKeys: (NSArray*) attributeKeys sellectors:(NSDictionary*) sellectors sellectorKeys: (NSArray*) selectorKeys completion: (void (^)(NSDictionary*, NSManagedObjectContext*)) completion;


- (void) update;
- (void) createInManagedObjectContext: (NSManagedObjectContext*) moc;

@property (nonatomic, strong) id<ObjectVerifyerView> view;
@property (nonatomic, strong) NSDictionary* attributeInputs;
@property (nonatomic, strong) NSDictionary* attributeSellectionInputs;
@property (nonatomic, strong) NSArray* orderedAttributeKeys;
@property (nonatomic, strong) NSArray* orderedSelectorKeys;
@property (nonatomic, getter = isVerified) bool objectVerified;

@end
