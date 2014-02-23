//
//  TeacherAquirement+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirement.h"
#import "TeacherAquirementDescription+Create.h"

@interface TeacherAquirement (Create)

+ (TeacherAquirement*) teacherAquirementWithDescription: (TeacherAquirementDescription*) teacherAquirementDescription enrollment: (Enrollment*) enrollment managedObjectContext: (NSManagedObjectContext*) moc;

- (void) setGrade:(NSNumber *)grade managedObjectContext: (NSManagedObjectContext*) moc;
+ (NSFetchRequest*) fetchRequestForTeacherAquirementsForEnrollment: (Enrollment*) enrollment;

@end
