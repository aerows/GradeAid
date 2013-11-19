//
//  Teacher+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Teacher.h"

static NSString *const KeyForSchoolClass    = @"schoolClass";
static NSString *const KeyForPassword       = @"password";
static NSString *const KeyForEmail          = @"email";
static NSString *const KeyForFirstName      = @"firstname";
static NSString *const KeyForLastName       = @"lastname";
static NSString *const KeyForPicture        = @"picture";
static NSString *const KeyForTeacherID      = @"teacherID";

@interface Teacher (Create)

+ (Teacher*) teacherWithAttributes: (NSDictionary*) attributes managedObjectContext: (NSManagedObjectContext*) moc;

+ (Teacher*) teacherWithEmail: (NSString*) email password: (NSString*) password managedObjectContext: (NSManagedObjectContext*) moc;

@end
