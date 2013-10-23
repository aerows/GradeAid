//
//  Subject+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-10.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Subject.h"

static NSString *const KeyForCourseIDs           = @"courseIDs";
static NSString *const KeyForIntroCaption        = @"introCaption";
static NSString *const KeyForSubjectName         = @"name";
static NSString *const KeyForObjectiveCaption    = @"objectiveCaption";
static NSString *const KeyForObjectiveItems      = @"objectiveItems";
static NSString *const KeyForSubjectID           = @"subjectID";
static NSString *const KeyForCourses             = @"courses";
static NSString *const KeyForObjectiveItemHeader = @"objectiveItemHeader";

@interface Subject (Create)

+ (Subject*) subjectWithDict: (NSDictionary *) dict inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (Subject*) subjectWithID: (NSNumber *) subjectID  inManagedObjectContext: (NSManagedObjectContext*) moc;

@end
