//
//  Enrollment+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Enrollment.h"
#import "Course+Create.h"
#import "Student+Create.h"
#import "Aquirement+Manage.h"
#import "CourseEdition+Create.h"

static NSString *const KeyForStudent = @"student";
static NSString *const KeyForCourse  = @"course";

@interface Enrollment (Create)

+ (Enrollment*) enroll: (Student*) student inCourse: (Course*) course managedObjectContext: (NSManagedObjectContext*) moc;

//+ (Enrollment*) createEnrollmentWithAttributes: (NSDictionary*) attributes  inManagedObjectContext: (NSManagedObjectContext*) moc;
//
//+ (Enrollment*) enrollmentWithAttributes: (NSDictionary*) attributes inManagedObjectContext: (NSManagedObjectContext*) moc;

+ (NSArray*) students: (NSArray*) students enrolledInOtherCourseThan: (Course*) course;

+ (NSArray*) enrollmentsForStudents: (NSArray*) students withCourseDescription: (CourseDescription*) courseDescription managedObjectContext: (NSManagedObjectContext*) moc;

+ (NSArray*) studentLastNameSortDescriptors;

- (void) updateEnrollmentInManagedObjectContext: (NSManagedObjectContext*) moc;

- (void) enrollInCourse: (Course*) course managedObjectContext: (NSManagedObjectContext*) moc;
- (void) unEnrollCourseInManagedObjectContext: (NSManagedObjectContext*) moc;


@end
