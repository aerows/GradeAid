//
//  CourseEdition+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseEdition+Create.h"
#import "Teacher+Create.h"
#import "CourseDescription+Create.h"

@implementation CourseEdition (Create)

+ (CourseEdition*) courseEditionWithAttributes:(NSDictionary *)attributes managedObjectContext:(NSManagedObjectContext *)moc
{
    CourseEdition *courseEdition = nil;
    
    courseEdition = [NSEntityDescription insertNewObjectForEntityForName: @"CourseEdition" inManagedObjectContext:moc];
    
    courseEdition.teacher =           [attributes objectForKey: KeyForTeacher];
    courseEdition.courseDescription = [attributes objectForKey: KeyForCourseDescription];

    return courseEdition;
}

+ (CourseEdition*) courseEditionForTeacher: (Teacher*) teacher courseDescription: (CourseDescription*) courseDescription managedObjectContext: (NSManagedObjectContext*) moc
{
    CourseEdition *courseEdition = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseEdition"];
    request.predicate = [NSPredicate predicateWithFormat: @"(teacher = %@ AND courseDescription = %@)", teacher, courseDescription];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        courseEdition = [response lastObject];
    }
    else
    {
        courseEdition = [NSEntityDescription insertNewObjectForEntityForName: @"CourseEdition" inManagedObjectContext:moc];
        
        courseEdition.teacher = teacher;
        courseEdition.courseDescription = courseDescription;
    }
    return courseEdition;
}

@end
