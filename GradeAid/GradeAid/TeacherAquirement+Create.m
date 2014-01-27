//
//  TeacherAquirement+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirement+Create.h"
#import "Enrollment+Create.h"

@implementation TeacherAquirement (Create)

+ (TeacherAquirement*) teacherAquirementWithDescription:(TeacherAquirementDescription *)aquirementDescription enrollment:(Enrollment *)enrollment managedObjectContext:(NSManagedObjectContext *) moc
{
    TeacherAquirement *teacherAquirement = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: @"TeacherAquirement"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(teacherAquirementDescription == %@ AND enrollment == %@)", aquirementDescription, enrollment];
    fetchRequest.predicate = predicate;
    
    NSError *error = nil;
    
    NSArray *response = [moc executeFetchRequest: fetchRequest error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    else if (response.count == 1)
    {
        teacherAquirement = [response lastObject];
    }
    else
    {
        teacherAquirement = [NSEntityDescription insertNewObjectForEntityForName: @"TeacherAquirement" inManagedObjectContext:moc];
        teacherAquirement.teacherAquirementDescription = aquirementDescription;
        teacherAquirement.enrollment            = enrollment;
        teacherAquirement.grade                 = @0;
    }
    
    return teacherAquirement;
}

- (void) setGrade:(NSNumber *)grade managedObjectContext:(NSManagedObjectContext *)moc
{
    [self setGrade: grade];
    [moc save: nil];
}

@end
