//
//  Teacher+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Teacher+Create.h"

@implementation Teacher (Create)

+ (Teacher*) teacherWithAttributes:(NSDictionary *)attributes managedObjectContext:(NSManagedObjectContext *)moc
{
    Teacher *teacher = nil;
    
    teacher = [NSEntityDescription insertNewObjectForEntityForName: @"Teacher" inManagedObjectContext: moc];
    
    teacher.firstName = [attributes objectForKey: KeyForFirstName];
    teacher.lastName  = [attributes objectForKey: KeyForLastName];
    teacher.email     = [attributes objectForKey: KeyForEmail];
    teacher.password  = [attributes objectForKey: KeyForPassword];
    
//    teacher.teacherID  = [attributes objectForKey: KeyForTeacherID];
//    teacher.picture  = [attributes objectForKey: KeyForPicture];

    return teacher;
}

+ (Teacher*) teacherWithEmail:(NSString *)email password:(NSString *)password managedObjectContext:(NSManagedObjectContext *)moc
{
    Teacher *teacher = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Teacher"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(email = %@ AND password = %@)", email, password];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *response = [moc executeFetchRequest: request error: &error];
    
    if (!response || response.count > 1)
    {
        for (Teacher *t in response)
        {
            if (!t.schools.count)
            {
                [moc deleteObject: t];
                [moc save: nil];
            }
        }
        
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        teacher = [response lastObject];
    }
    return teacher;
}

@end
