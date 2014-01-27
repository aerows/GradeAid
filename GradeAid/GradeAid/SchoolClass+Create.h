//
//  SchoolClass+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClass.h"
#import "Creatable.h"

static NSString *const KeyForSchoolClassName = @"name";
static NSString *const KeyForSchoolClassYear = @"year";
static NSString *const KeyForSchool          = @"school";
static NSString *const KeyForSuffix          = @"suffix";


@interface SchoolClass (Create) <Creatable, CellPresentable>

+ (SchoolClass*) createSchoolClassWithAttributes:(NSDictionary *) attributes InManagedObjectContext:(NSManagedObjectContext *)moc;
+ (SchoolClass*) schoolClassWithSchool: (School*) school year: (NSNumber*) year suffix: (NSString*) suffix highschool: (NSNumber*) isHighschool managedObjectContext: (NSManagedObjectContext*) moc;

- (NSString*) schoolClassName;
- (NSString*) fullSchoolClassName;

+ (NSArray*) schoolClassesForCurrentTeacher;
+ (NSArray*) schoolClassesForSchool: (School*) school;

- (NSArray*) sortedStudents;

+ (UIImage*) defaultImage;
- (UIImage*) schoolClassImage;

+ (BOOL) deleteSchoolClass: (SchoolClass*) schoolClass;
@end
