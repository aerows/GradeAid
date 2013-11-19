//
//  SubjectObjective+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectObjective+Create.h"
#import "Subject+Create.h"

@implementation SubjectObjective (Create)

+ (SubjectObjective*) subjectObjectiveWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    SubjectObjective *subjectObj = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"SubjectObjective"];
    request.predicate = [NSPredicate predicateWithFormat: @"(index = %@ AND subject.subjectID = %@)",
                         [dict objectForKey: KeyForIndex],
                         [dict objectForKey: KeyForSubjectID]];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        subjectObj = [response lastObject];
    }
    else
    {
        subjectObj = [NSEntityDescription insertNewObjectForEntityForName: @"SubjectObjective" inManagedObjectContext:moc];
        
        subjectObj.index = [dict objectForKey: KeyForIndex];
        subjectObj.caption = [dict objectForKey: KeyForSubjectObjectiveCaption];
        
#warning should subject be added here as well?
        
    }
    return subjectObj;
}

@end