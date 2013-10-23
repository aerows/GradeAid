//
//  Enrollment+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Enrollment+Create.h"

@implementation Enrollment (Create)

+ (Enrollment*) createEnrollmentWithAttributes: (NSDictionary*) attributes  inManagedObjectContext: (NSManagedObjectContext*) moc;
{
    Enrollment *enrollment = nil;
    
    enrollment = [NSEntityDescription insertNewObjectForEntityForName: @"Enrollment" inManagedObjectContext: moc];
    
    enrollment.student  = [attributes objectForKey: KeyForStudent];
    enrollment.course   = [attributes objectForKey: KeyForCourse];
    

    return enrollment;
}

@end
