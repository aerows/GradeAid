//
//  TeacherAquirementDescription+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementDescription.h"

@interface TeacherAquirementDescription (Create)

+ (TeacherAquirementDescription*) teacherAquirementDescriptionWithCourseDescription: (CourseEdition*) courseEdition teacher: (Teacher*) teacher caption: (NSString*) caption managedObjectContext: (NSManagedObjectContext*) moc;

@end
