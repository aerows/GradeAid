//
//  Aquirement+Manage.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Aquirement+Manage.h"

@implementation Aquirement (Manage)

+ (Aquirement*) createWithCourseAquirementDescription: (AquirementDescription*) aquirementDescription inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Aquirement *aquirement = nil;
    
    aquirement.aquirementDescription = aquirementDescription;
    
    return aquirement;
}

@end
