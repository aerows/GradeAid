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

@implementation Course (Create)

+ (Course*) courselWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Course *course = nil;
    
    course = [NSEntityDescription insertNewObjectForEntityForName: @"Course" inManagedObjectContext:moc];
    
    return course;
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
#warning - sort this after student surname
    
  //  NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"SELF.student" ascending:<#(BOOL)#>
    return [self.enrollments allObjects];
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

@end


