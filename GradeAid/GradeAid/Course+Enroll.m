//
//  Course+Enroll.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Course+Enroll.h"
#import "CourseDescription+Create.h"
#import "Aquirement+Manage.h"
#import "Enrollment.h"
#import "AquirementDescription+Create.h"

@implementation Course (Enroll)

- (void) setupAquirementsForEnrollment: (Enrollment*) enrollment inManagedObjectContext: (NSManagedObjectContext*) moc
{
    for (AquirementDescription* cad in self.courseDescription.aquirementDescriptions)
    {
        [enrollment addAquirementsObject: [Aquirement createWithCourseAquirementDescription: cad inManagedObjectContext: moc]];
    }
//    for (CustomAquirementDescription* cad in self.courseDescription.customAquirementDescriptions)
//    {
//        [enrollment addAquirementsObject: [Aquirement createWithCustomAquirementDescription: cad inManagedObjectContext: moc]];
//    }
}

@end
