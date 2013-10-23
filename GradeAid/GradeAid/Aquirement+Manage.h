//
//  Aquirement+Manage.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Aquirement.h"
#import "CourseDescription+Create.h"
#import "AquirementDescription.h"


@interface Aquirement (Manage)

+ (Aquirement*) createWithCourseAquirementDescription: (AquirementDescription*) aquirementDescription inManagedObjectContext: (NSManagedObjectContext*) moc;

- (NSAttributedString*) attributedStringForCurrentGrade: (int) grade;


@end
