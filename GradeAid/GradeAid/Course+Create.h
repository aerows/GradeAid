//
//  Course+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Course.h"
#import "Student+Create.h"
#import "SchoolClass+Create.h"

@interface Course (Create)

+ (Course*) courselWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;

- (void) enrollStudent: (Student*) student managedObjectContext: (NSManagedObjectContext*) moc;
- (void) enrollClass: (SchoolClass*) schoolClass managedObjectContext: (NSManagedObjectContext*) moc;

- (NSNumber*) courseID;
- (NSArray*) orderedEnrollments;

@end
