//
//  CourseDescription+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-10.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseDescription.h"
#import "CellPresentable.h"
#import "CourseCentralContent+Create.h"
#import "AquirementDescription+Create.h"

static NSString *const KeyForCourseID                    = @"courseID";
static NSString *const KeyForCredits                     = @"credits";
static NSString *const KeyForLevel                       = @"level";
static NSString *const KeyForCourseName                  = @"name";
static NSString *const KeyForScope                       = @"scope";
static NSString *const KeyForAquirementsDescriptionItems = @"aquirementDescriptionItems";
static NSString *const KeyForCentralContentItems         = @"centralContentItems";

@interface CourseDescription (Create) <CellPresentable>

+ (CourseDescription*) descriptionWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (NSArray*) allCourseDescriptionsInManagedObjectContext: (NSManagedObjectContext*) moc;

- (NSArray*) sortedCentralContentItems;
- (NSArray*) sortedCourseAquirements;


@end
