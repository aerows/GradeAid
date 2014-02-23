//
//  Student+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Student.h"
#import "Creatable.h"
#import "CellPresentable.h"
#import "Course+Create.h"

static NSString *const StudentKeyForSchoolClass    = @"schoolClass";
static NSString *const StudentKeyForStudentID      = @"studentID";
static NSString *const StudentKeyForEmail          = @"email";
static NSString *const StudentKeyForFirstName      = @"firstname";
static NSString *const StudentKeyForLastName       = @"lastname";
static NSString *const StudentKeyForPicture        = @"picture";

@interface Student (Create) <Creatable, CellPresentable>

+ (Student*) studentWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (NSArray*) studentsForCurrentTeacher;
+ (UIImage*) defaultImage;
- (UIImage*) studentImage;

+ (NSArray*) lastNameSortDescriptors;

- (NSString*) fullName;

- (NSArray*) sortedEnrollments;

+ (BOOL) deleteStudent: (Student*) student;

@end
