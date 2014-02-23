//
//  Student+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "NSManagedObject+Create.h"
#import "Student+Create.h"
#import "School+Create.h"
#import "SchoolClass+Create.h"
#import "CourseEdition+Create.h"
#import "Enrollment+Create.h"
#import "Session.h"
#import "AppDelegate.h"

@implementation Student (Create)

+ (Student*) studentWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Student *student = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"studentID = %@", [dict objectForKey: StudentKeyForStudentID]];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        student = [response lastObject];
    }
    else
    {
        NSNumber *studentID = [NSManagedObject nextIDforEntityName: @"Student" idKeyPath: @"studentID" managedObjectContext: moc];
        
        student = [NSEntityDescription insertNewObjectForEntityForName: @"Student" inManagedObjectContext:moc];
        
        student.firstName   = [dict objectForKey: StudentKeyForFirstName];
        student.lastName    = [dict objectForKey: StudentKeyForLastName];
        student.email       = [dict objectForKey: StudentKeyForEmail];
        
        student.picture       = UIImagePNGRepresentation([dict objectForKey: StudentKeyForPicture]);
        
        student.schoolClass = [dict objectForKey: StudentKeyForSchoolClass];
        
        student.studentID = studentID;

    }
    return student;
}

- (NSString*) title
{
    return [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
}

- (UIImage*) thumbNail
{
    return [UIImage imageNamed: @"student.jpg"];
}

+ (NSArray*) lastNameSortDescriptors
{
    return @[[NSSortDescriptor sortDescriptorWithKey: @"lastName" ascending: YES],
             [NSSortDescriptor sortDescriptorWithKey: @"firstName" ascending: YES]];
}

+ (NSArray*) studentsForCurrentTeacher
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"ANY schoolClass.school.teachers == %@", [Session currentSession].teacher];
    request.predicate = predicate;
    request.sortDescriptors = [Student lastNameSortDescriptors];
    
    NSError *error = nil;
    NSArray *response = [[AppDelegate sharedDelegate].managedObjectContext executeFetchRequest: request error: &error];
    if (!response)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    return response;

}

#pragma mark - Image Methods

- (UIImage*) studentImage
{
#warning - Databas lägg till image för student
    
    return [Student defaultImage];
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed: @"default-student"];
}

- (NSString*) fullName
{
    return [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
}

- (NSArray*) sortedEnrollments
{
    return [self.enrollments.allObjects sortedArrayUsingDescriptors: [Student defualtEnrollmentSortDescriptors]];
}

+ (NSArray*) defualtEnrollmentSortDescriptors
{
    return @[[NSSortDescriptor sortDescriptorWithKey: @"course.courseEdition.courseDescription.name" ascending: YES], [NSSortDescriptor sortDescriptorWithKey: @"course.courseEdition.courseDescription.level" ascending:YES], [NSSortDescriptor sortDescriptorWithKey: @"course.name" ascending: YES]];
}


+ (BOOL) deleteStudent:(Student *)student
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    [moc deleteObject: student];
    return [moc save: nil];
}


@end
