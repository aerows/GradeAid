//
//  Session.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher+Create.h"

@interface Session : NSObject

+(Session*) currentSession;

- (bool) loginWithEmail: (NSString*) email password: (NSString*) password;
- (bool) logout;

// Debugging

+ (Session*) autoSession;

@property (nonatomic, readonly, getter = isActive) bool active;
@property (nonatomic, strong) Teacher* teacher;

@end
