//
//  School+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "School.h"
#import "Creatable.h"
#import "CellPresentable.h"

static NSString *const KeyForSchoolName = @"name";
static NSString *const KeyForSchoolID   = @"schoolID";
static NSString *const KeyForSchoolImage = @"image";
static NSString *const KeyForSchoolImageURL = @"imageURL";

@interface School (Create) <Creatable, CellPresentable>

+ (School*) schoolWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (School*) schoolWithSchoolID: (NSNumber*) schoolID inManagedObjectContext: (NSManagedObjectContext*) moc;
+ (NSArray*) schoolsForCurrentTeacher;

+ (UIImage*) defaultImage;
- (UIImage*) schoolImage;


@end
