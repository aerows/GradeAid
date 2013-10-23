//
//  Gradation+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-23.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Gradation.h"

static NSString *const KeyForGradationCaption       = @"gradationCaption";
static NSString *const KeyForGradationLevel         = @"gradationLevel";
static NSString *const KeyForLevelCaption           = @"levelCaption";
static NSString *const KeyForAquirementDescription  = @"aquirementDescription";

@interface Gradation (Create)

+ (Gradation*) gradationWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
