//
//  CourseEdition+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseEdition.h"

static NSString *const KeyForTeacher                    = @"teacher";
static NSString *const KeyForCourseDescription          = @"courseDescription";
static NSString *const KeyForAquirementDescriptions     = @"aquirementDescriptions";

@interface CourseEdition (Create)

+ (CourseEdition*) courseEditionWithAttributes: (NSDictionary*) attributes managedObjectContext: (NSManagedObjectContext*) moc;

@end
