//
//  CourseCentralContent+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseCentralContent.h"

static NSString *const KeyForCentralContentIndex        = @"index";
static NSString *const KeyForCentralContentCaption      = @"caption";
static NSString *const KeyForCentralContentSectionTitle = @"sectionTitle";

@interface CourseCentralContent (Create)

+ (CourseCentralContent*) centralContentWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
