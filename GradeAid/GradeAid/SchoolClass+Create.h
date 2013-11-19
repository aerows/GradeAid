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

@interface SchoolClass (Create) <Creatable, CellPresentable>

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) NSSet *students;

+ (SchoolClass*) createSchoolClassWithAttributes:(NSDictionary *) attributes InManagedObjectContext:(NSManagedObjectContext *)moc;

+ (NSArray*) schoolClassesForCurrentTeacher;
+ (NSArray*) schoolClassesForSchool: (School*) school;

- (NSArray*) sortedStudents;

@end
