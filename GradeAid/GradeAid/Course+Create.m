//
//  Course+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Course+Create.h"
#import "NSManagedObject+Create.h"
#import "Enrollment+Create.h"
#import "Session.h"
#import "AppDelegate.h"

@implementation Course (Create)

+ (Course*) courselWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Course *course = nil;
    
    course = [NSEntityDescription insertNewObjectForEntityForName: @"Course" inManagedObjectContext:moc];
    
    return course;
}

+ (Course*) courseWithCourseDescription: (CourseDescription*) courseDescription teacher: (Teacher*) teacher managedObjectContext: (NSManagedObjectContext*) moc
{
    Course *course = nil;
    
    CourseEdition *courseEdition = [CourseEdition courseEditionForTeacher: teacher courseDescription: courseDescription managedObjectContext: moc];
    
    course = [Course courselWithDict: @{} inManagedObjectContext: moc];
    
    course.teacher = teacher;
    course.courseEdition = courseEdition;
    
    return course;
}

+ (NSArray*) coursesForCurrentTeacher
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Course"];
    
    request.predicate = [NSPredicate predicateWithFormat: @"teacher = %@", [Session currentSession].teacher];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"courseEdition.courseDescription.name" ascending: YES], [NSSortDescriptor sortDescriptorWithKey: @"courseEdition.courseDescription.level" ascending:YES], [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]];
    
    NSError *error;
    NSArray *response = [[AppDelegate sharedDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    if (!response)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return response;
}

- (void) enrollStudent:(Student *)student managedObjectContext:(NSManagedObjectContext *)moc
{
    Enrollment *enrollment = [Enrollment enroll:student inCourse: self managedObjectContext: moc];
    [self addEnrollmentsObject: enrollment];
}

- (void) enrollClass:(SchoolClass *)schoolClass managedObjectContext:(NSManagedObjectContext *)moc
{
    for (Student *student in schoolClass.students)
    {
        [self enrollStudent: student managedObjectContext: moc];
    }
}

- (NSNumber*) courseID
{
    return self.courseEdition.courseDescription.courseID;
}

- (NSArray*) orderedEnrollments
{
    return [[self.enrollments allObjects] sortedArrayUsingDescriptors: [Enrollment studentLastNameSortDescriptors]];
    //return [self.enrollments allObjects];
}

#pragma mark - Image Methods

- (UIImage*) courseImage
{
    return [Course defaultImage];
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed:@"default-course"];
}

+ (NSArray*) defaultSortDescriptors
{
    NSSortDescriptor *sortByCourseName = [NSSortDescriptor sortDescriptorWithKey: @"courseEdition.courseDescription.name" ascending: YES];
    NSSortDescriptor *sortByCourseLevel = [NSSortDescriptor sortDescriptorWithKey: @"courseEdition.courseDescription.level" ascending: YES];
    NSSortDescriptor *sortByDescription = [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES];

    return @[sortByCourseName, sortByCourseLevel, sortByDescription];
}

- (NSArray*) schoolClasses
{
    NSArray *classes = [[self.enrollments allObjects] valueForKeyPath: @"@distinctUnionOfObjects.student.schoolClass"];
    
    //NSSet *classes = [NSSet setWithArray:[self.enrollments valueForKeyPath:@"student.schoolClass"]];
    NSSortDescriptor *schoolSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"school.name" ascending: YES];
    NSSortDescriptor *yearSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"year" ascending: YES];
    NSSortDescriptor *suffixSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"suffix" ascending: YES];
    return [classes sortedArrayUsingDescriptors: @[schoolSortDesc, yearSortDesc, suffixSortDesc]];
}

- (NSArray*) students
{
    NSSortDescriptor *firstNameSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"firstName" ascending: YES];
    NSSortDescriptor *lastNameSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"lastName" ascending: YES];
    return [[self.enrollments valueForKeyPath: @"@distinctUnionOfObjects.student"] sortedArrayUsingDescriptors: @[lastNameSortDesc, firstNameSortDesc]];
}

- (NSString*) fullNameDescription
{
    return [NSString stringWithFormat: @"%@, %@ - %@", self.courseEdition.courseDescription.name,
            self.courseEdition.courseDescription.level, self.name];
}

- (NSArray*) teacherAquirementDescriptions
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"TeacherAquirementDescription"];
    request.predicate = [NSPredicate predicateWithFormat: @"SELF IN %@", self.courseEdition.teacherAquirementDescriptions];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"caption" ascending: YES]]];
    return [[AppDelegate sharedDelegate].managedObjectContext executeFetchRequest: request error: nil];
}

@end


