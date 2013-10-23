//
//  SubjectObjective+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectObjective.h"

static NSString *const KeyForIndex = @"index";
static NSString *const KeyForSubjectObjectiveCaption = @"caption";

@interface SubjectObjective (Create)

+ (SubjectObjective*) subjectObjectiveWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
