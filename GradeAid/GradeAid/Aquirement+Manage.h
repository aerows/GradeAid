//
//  Aquirement+Manage.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Aquirement.h"
#import "CourseDescription+Create.h"
#import "AquirementDescription+Create.h"

static NSString *const KeyForAquirementDescription = @"aquirementDescription";
static NSString *const KeyForEnrollment            = @"enrollment";

@interface Aquirement (Manage)

//+ (Aquirement*) aquirementWithAttributes: (NSDictionary*) attributes inManagedObjectContext: (NSManagedObjectContext*) moc;

+ (Aquirement*) aquirementWithDescription: (AquirementDescription*) aquirementDescription enrollment: (Enrollment*) enrollment managedObjectContext: (NSManagedObjectContext*) moc;

- (NSAttributedString*) attributedStringForCurrentGrade: (int) grade;
- (void) setGrade:(NSNumber *)grade managedObjectContext: (NSManagedObjectContext*) moc;

@end
