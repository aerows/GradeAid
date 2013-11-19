//
//  CourseEdition+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseEdition+Create.h"

@implementation CourseEdition (Create)

+ (CourseEdition*) courseEditionWithAttributes:(NSDictionary *)attributes managedObjectContext:(NSManagedObjectContext *)moc
{
    CourseEdition *courseEdition = nil;
    
    courseEdition = [NSEntityDescription insertNewObjectForEntityForName: @"CourseEdition" inManagedObjectContext:moc];
    
    courseEdition.teacher =           [attributes objectForKey: KeyForTeacher];
    courseEdition.courseDescription = [attributes objectForKey: KeyForCourseDescription];

    return courseEdition;
}

@end
