//
//  Course+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Course+Create.h"

@implementation Course (Create)
+ (Course*) createCourseForTeacher:(Teacher *)teacher withCourseDescription:(CourseDescription *)desc inManagedObjectContext:(NSManagedObjectContext *)moc
{
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName: @"Course" inManagedObjectContext:moc];
    course.teacher = teacher;
    course.courseDescription = desc;
    return course;
}
@end


