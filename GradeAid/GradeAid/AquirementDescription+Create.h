//
//  AquirementDescription+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AquirementDescription.h"

static NSString *const KeyForSectionTitle       = @"sectionTitle";
static NSString *const KeyForNrOfGradations     = @"nrOfGradations";
//static NSString *const KeyForCourseID           = @"courseID";
static NSString *const KeyForAquirementDescID   = @"aquirementDescriptionID";
static NSString *const KeyForCaption            = @"caption";
static NSString *const KeyForGradations         = @"gradations";
static NSString *const KeyForAquirementType     = @"aquirementType";

/* slutats användas */
static NSString *const KeyForA_Caption            = @"a_caption";
static NSString *const KeyForC_Caption            = @"c_caption";
static NSString *const KeyForE_Caption            = @"e_caption";


@interface AquirementDescription (Create)

+ (AquirementDescription*) descriptionWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
