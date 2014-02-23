//
//  TeacherAquirementDescription+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementDescription+Create.h"
#import "CourseEdition+Create.h"
#import "Enrollment+Create.h"

#import "AppDelegate.h"

@implementation TeacherAquirementDescription (Create)

+ (TeacherAquirementDescription*) teacherAquirementDescriptionWithCourseDescription: (CourseEdition*) courseEdition teacher: (Teacher*) teacher caption: (NSString*) caption managedObjectContext: (NSManagedObjectContext*) moc
{
    TeacherAquirementDescription *teacherAquirementDescription = nil;
    
    teacherAquirementDescription = [NSEntityDescription insertNewObjectForEntityForName: @"TeacherAquirementDescription" inManagedObjectContext:moc];

    teacherAquirementDescription.teacher = teacher;
    teacherAquirementDescription.courseEdition = courseEdition;
    teacherAquirementDescription.caption = caption;
    
    [courseEdition addTeacherAquirementDescriptionsObject: teacherAquirementDescription];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Enrollment"];
    request.predicate = [NSPredicate predicateWithFormat: @"%@ IN courseEditions", courseEdition];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (response && response.count)
    {
        for (Enrollment *enrollment in response)
        {
            [enrollment updateEnrollmentInManagedObjectContext: moc];
        }
    }
    
    return teacherAquirementDescription;
}

+ (BOOL) deleteTeacherAquirement:(TeacherAquirementDescription *) teacherAquirementDescription
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    [moc deleteObject: teacherAquirementDescription];
    return [moc save: nil];
}


@end
