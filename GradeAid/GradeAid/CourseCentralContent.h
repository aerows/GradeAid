//
//  CourseCentralContent.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDescription;

@interface CourseCentralContent : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * sectionTitle;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) CourseDescription *course;

@end
