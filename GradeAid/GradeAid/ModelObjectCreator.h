//
//  ModelObjectCreater.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-05.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeVerifyer.h"

@protocol ModelObjectCreatorDelegateViewController <NSObject>

- (void) modelObjectCreator: (id) sender createdObjects: (NSArray*) objects;
- (void) presentViewController:(UIViewController *) viewControllerToPresent animated: (BOOL) flag completion:(void (^)(void))completion;

@end

@interface ModelObjectCreator : NSObject <AttributeVerifyerDelegate>

- (void) show;

@property(nonatomic, strong) id<ModelObjectCreatorDelegateViewController> delegate;

@end
