//
//  Enrollment+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Enrollment+Create.h"
#import "TeacherAquirement+Create.h"

@implementation Enrollment (Create)

+ (Enrollment*) enroll: (Student*) student inCourse: (Course*) course managedObjectContext: (NSManagedObjectContext*) moc
{
    Enrollment *enrollment = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Enrollment"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(course = %@ AND student = %@)", course, student];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        enrollment = [response lastObject];
    }
    else
    {
        enrollment = [Enrollment enrollmentForStudent: student courseDescription: course.courseEdition.courseDescription managedObjectContext: moc];
        
        enrollment.course = course;
        [enrollment addCourseEditionsObject: course.courseEdition];
    }
    
    [enrollment updateEnrollmentInManagedObjectContext: moc];
    
    return enrollment;
}

+ (Enrollment*) enrollmentForStudent: (Student*) student courseDescription: (CourseDescription*) courseDescription managedObjectContext: (NSManagedObjectContext*) moc
{
    Enrollment *enrollment = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Enrollment"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(courseDescription = %@ AND student = %@)", courseDescription, student];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        enrollment = [response lastObject];
    }
    else
    {
        enrollment = [NSEntityDescription insertNewObjectForEntityForName: @"Enrollment" inManagedObjectContext:moc];
        
        enrollment.student = student;
        enrollment.courseDescription = courseDescription;
    }
    
    [enrollment updateEnrollmentInManagedObjectContext: moc];
    
    return  enrollment;
}


- (void) updateEnrollmentInManagedObjectContext:(NSManagedObjectContext *)moc
{
    for (AquirementDescription *ad in self.courseDescription.aquirementDescriptions)
    {
        Aquirement *aquirement = [Aquirement aquirementWithDescription: ad enrollment: self managedObjectContext: moc];
        [self addAquirementsObject: aquirement];
    }
    
    for (TeacherAquirementDescription *tad in self.course.courseEdition.teacherAquirementDescriptions)
    {
        TeacherAquirement *teacherAquirement = [TeacherAquirement teacherAquirementWithDescription:tad enrollment:self managedObjectContext:moc];
        [self addTeacherAquirementsObject: teacherAquirement];
    }
}


//+ (Enrollment*) createEnrollmentWithAttributes: (NSDictionary*) attributes  inManagedObjectContext: (NSManagedObjectContext*) moc;
//{
//    Enrollment *enrollment = nil;
//    
//    enrollment = [NSEntityDescription insertNewObjectForEntityForName: @"Enrollment" inManagedObjectContext: moc];
//    
//    enrollment.student  = [attributes objectForKey: KeyForStudent];
//    enrollment.course   = [attributes objectForKey: KeyForCourse];
//    
//
//    return enrollment;
//}
//
//+ (Enrollment*) enrollmentWithAttributes: (NSDictionary*) attributes inManagedObjectContext: (NSManagedObjectContext*) moc
//{
//    Enrollment *enrollment = nil;
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Enrollment"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(course = %@ AND student = %@ student)",
//                              [attributes objectForKey: KeyForCourse],[attributes objectForKey: KeyForStudent]];
//    request.predicate = predicate;
//    
//    NSError *error = nil;
//    
//    NSArray *response = [moc executeFetchRequest: request error: &error];
//    
//    if (!response || response.count > 1)
//    {
//        NSLog(@"%@", error.localizedDescription);
//    }
//    else if (response.count == 1)
//    {
//        enrollment = [response lastObject];
//    }
//    else
//    {
//        enrollment = [NSEntityDescription insertNewObjectForEntityForName: @"Enrollment" inManagedObjectContext: moc];
//        enrollment.student  = [attributes objectForKey: KeyForStudent];
//        enrollment.course   = [attributes objectForKey: KeyForCourse];
//        
//        for (AquirementDescription *ad in enrollment.course.courseEdition.courseDescription.aquirementDescriptions)
//        {
//            NSDictionary *attributes = @{KeyForEnrollment            : enrollment,
//                                         KeyForAquirementDescription : ad};
//            Aquirement *aquirement = [Aquirement aquirementWithAttributes: attributes inManagedObjectContext:moc];
//            [enrollment addAquirementsObject: aquirement];
//        }
//    }
//
//    return enrollment;
//}

+ (NSArray*) studentLastNameSortDescriptors
{
    return @[[NSSortDescriptor sortDescriptorWithKey: @"student.lastName" ascending: YES],
             [NSSortDescriptor sortDescriptorWithKey: @"student.firstName" ascending: YES]];
}

+ (NSArray*) enrollmentsForStudents: (NSArray*) students withCourseDescription: (CourseDescription*) courseDescription managedObjectContext: (NSManagedObjectContext*) moc
{
    NSMutableArray *enrollments = [[NSMutableArray alloc] initWithCapacity: students.count];
    for (Student *s in students)
    {
        [enrollments addObject: [Enrollment enrollmentForStudent: s courseDescription: courseDescription managedObjectContext: moc]];
    }
    return enrollments;
}

- (void) enrollInCourse: (Course*) course managedObjectContext: (NSManagedObjectContext*) moc
{
    self.course = course;
    [course addEnrollmentsObject: self];
    [self addCourseEditionsObject: course.courseEdition];
    [self updateEnrollmentInManagedObjectContext: moc];
}

- (void) unEnrollCourseInManagedObjectContext:(NSManagedObjectContext *)moc
{
    Course *course = self.course;
    [course removeEnrollmentsObject: self];
    self.course = nil;
}

@end
