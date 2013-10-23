//
//  Student+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//


#import "Student+Create.h"

@implementation Student (Create)

+ (Student*) createMockupWithFirstname: (NSString*) firstName lastName: (NSString*) lastName inManagedObjectContext:(NSManagedObjectContext *) moc
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName: @"Student" inManagedObjectContext:moc];

    student.firstname = firstName;
    student.lastname  = lastName;
    
    student.image = UIImagePNGRepresentation([UIImage imageNamed: @"student.jpg"]);
    student.email = @"namn@email.com";
    
    return student;
}

+ (Student*) createWithDict: (NSDictionary*) dict inManagedObjectContext:(NSManagedObjectContext *) moc
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName: @"Student" inManagedObjectContext:moc];
    
    student.firstname   = [dict objectForKey: KeyForFirstName];
    student.lastname    = [dict objectForKey: KeyForLastName];
    student.email       = [dict objectForKey: KeyForEmail];
    
    student.image = UIImagePNGRepresentation([dict objectForKey: KeyForImage]);
    
    student.schoolClass = [dict objectForKey: KeyForSchoolClass];

// student.studentID = []; KeyForStudentID;
    
    return student;
}

@end
