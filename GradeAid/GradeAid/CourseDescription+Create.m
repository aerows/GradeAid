//
//  CourseDescription+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-10.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseDescription+Create.h"
#import "CourseAquirementDescription+Create.h"
#import "Subject+Create.h"
#import "CourseCentralContent+Create.h"
#import "AquirementDescription+Create.h"

@implementation CourseDescription (Create)

+ (CourseDescription*) descriptionWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    CourseDescription *desc = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseDescription"];
    request.predicate = [NSPredicate predicateWithFormat: @"courseID = %@", [dict objectForKey: KeyForCourseID]];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        desc = [response lastObject];
    }
    else
    {
        desc = [NSEntityDescription insertNewObjectForEntityForName: @"CourseDescription" inManagedObjectContext:moc];
        
        desc.courseID  = [dict objectForKey: KeyForCourseID];
        desc.name      = [dict objectForKey: KeyForCourseName];
        desc.level     = [dict objectForKey: KeyForLevel];
        desc.credits   = [dict objectForKey: KeyForCredits];
        desc.scope     = [dict objectForKey: KeyForScope];
        desc.subjectID = [dict objectForKey: KeyForSubjectID];
        
        for (NSDictionary *cc in [dict objectForKey: KeyForCentralContentItems])
        {
            [desc addCentralContentItemsObject: [CourseCentralContent centralContentWithDict: cc inManagedObjectContext:moc]];
        }
        
        
        for (NSDictionary *ad in [dict objectForKey: KeyForAquirementsDescriptionItems])
        {
            [desc addAquirementDescriptionsObject: [AquirementDescription descriptionWithDict: ad inManagedObjectContext: moc]];
        }
        //desc.subject = [Subject subjectWithID:[dict objectForKey: KeyForSubjectID] inManagedObjectContext:moc];
    }
    
    return desc;
}

@end
