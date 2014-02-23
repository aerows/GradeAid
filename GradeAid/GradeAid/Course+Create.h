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
#import "CourseDescription+Create.h"

@interface Course (Create)

+ (Course*) courselWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (Course*) courseWithCourseDescription: (CourseDescription*) courseDescription teacher: (Teacher*) teacher managedObjectContext: (NSManagedObjectContext*) moc;


- (void) enrollStudent: (Student*) student managedObjectContext: (NSManagedObjectContext*) moc;
- (void) enrollClass: (SchoolClass*) schoolClass managedObjectContext: (NSManagedObjectContext*) moc;

+ (NSArray*) coursesForCurrentTeacher;
+ (NSArray*) defaultSortDescriptors;

- (NSNumber*) courseID;
- (NSArray*) orderedEnrollments;

+ (UIImage*) defaultImage;
- (UIImage*) courseImage;

- (NSArray*) schoolClasses;
- (NSArray*) students;

- (NSString*) fullNameDescription;

@end
