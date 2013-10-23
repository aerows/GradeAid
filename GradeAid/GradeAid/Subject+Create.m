//
//  Subject+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-10.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Subject+Create.h"
#import "SubjectObjective+Create.h"
#import "CourseDescription+Create.h"

@implementation Subject (Create)

+ (Subject*) subjectWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc;
{
    Subject *subject = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Subject"];
    request.predicate = [NSPredicate predicateWithFormat: @"subjectID = %@", [dict objectForKey: KeyForSubjectID]];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        subject = [response lastObject];
    }
    else
    {
        subject = [NSEntityDescription insertNewObjectForEntityForName: @"Subject" inManagedObjectContext:moc];
        
        subject.introCaption        = [dict objectForKey:  KeyForIntroCaption];
        subject.name                = [dict objectForKey:  KeyForSubjectName];
        subject.objectiveCaption    = [dict objectForKey:  KeyForObjectiveCaption];
        subject.subjectID           = [dict objectForKey:  KeyForSubjectID];
        subject.objectiveItemHeader = [dict objectForKey: KeyForObjectiveItemHeader];
        
        for (NSDictionary *objective in [dict objectForKey: KeyForObjectiveItems])
        {
            [subject addObjectivesObject: [SubjectObjective subjectObjectiveWithDict:objective inManagedObjectContext: moc]];
        }
        
        for (NSDictionary *courseDesc in [dict objectForKey: KeyForCourses])
        {
            [subject addCoursesObject: [CourseDescription descriptionWithDict:courseDesc inManagedObjectContext: moc]];
        }
        
    }
    
    return subject;
}

+ (Subject*) subjectWithID: (NSNumber *) subjectID  inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Subject *subject = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Subject"];
    request.predicate = [NSPredicate predicateWithFormat: @"courseID = %@", subjectID];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        subject = [response lastObject];
    }
    else
    {
        subject = [NSEntityDescription insertNewObjectForEntityForName: @"Subject" inManagedObjectContext:moc];
        subject.subjectID = subjectID;
    }
    
    return subject;

}

@end
