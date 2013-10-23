//
//  Course+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Course.h"

@interface Course (Create)

+ (Course*) createCourseForTeacher: (Teacher*) teacher withCourseDescription: (CourseDescription*) desc inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
