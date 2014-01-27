//
//  Session.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Session.h"
#import "AppDelegate.h"

@implementation Session

static Session* currentSession = nil;

+ (Session*) currentSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentSession = [[Session alloc] init];
    });
    return currentSession;
}

+ (Session*) autoSession
{
    Session *autoSession = [Session currentSession];
    [autoSession loginWithEmail: @"hallin.daniel@gmail.com" password: @"password"];
    return autoSession;
}

- (bool) loginWithEmail:(NSString *)email password:(NSString *)password
{
    _teacher = [Teacher teacherWithEmail: email password: password managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    _active = (bool) _teacher;
    return _active;
}

- (bool) logout
{
    _teacher = nil;
    _active = NO;
    return _active;
}

#pragma mark - Getters and Setters

@synthesize teacher = _teacher;
@synthesize active = _active;

@end
