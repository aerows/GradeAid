//
//  CourseCentralContent+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseCentralContent+Create.h"
#import "CourseDescription+Create.h"

@implementation CourseCentralContent (Create)

+ (CourseCentralContent*) centralContentWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    CourseCentralContent *centralContent = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseCentralContent"];
    request.predicate = [NSPredicate predicateWithFormat: @"(index = %@ AND course.courseID = %@)",
                         [dict objectForKey: KeyForCentralContentIndex],
                         [dict objectForKey: KeyForCourseID]];
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        centralContent = [response lastObject];
    }
    else
    {
        centralContent = [NSEntityDescription insertNewObjectForEntityForName: @"CourseCentralContent" inManagedObjectContext:moc];
        
        centralContent.index        = [dict objectForKey: KeyForCentralContentIndex];
        centralContent.caption      = [dict objectForKey: KeyForCentralContentCaption];
        centralContent.sectionTitle = [dict objectForKey: KeyForCentralContentSectionTitle];
        
#warning should subject be added here as well?
        
    }
    return centralContent;
}

@end
