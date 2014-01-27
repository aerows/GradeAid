//
//  Enrollment.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-22.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Aquirement, Course, CourseDescription, Student;

@interface Enrollment : NSManagedObject

@property (nonatomic, retain) NSSet *aquirements;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSSet *courseEditions;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) NSManagedObject *courseDescription;
@end

@interface Enrollment (CoreDataGeneratedAccessors)

- (void)addAquirementsObject:(Aquirement *)value;
- (void)removeAquirementsObject:(Aquirement *)value;
- (void)addAquirements:(NSSet *)values;
- (void)removeAquirements:(NSSet *)values;

- (void)addCourseEditionsObject:(CourseDescription *)value;
- (void)removeCourseEditionsObject:(CourseDescription *)value;
- (void)addCourseEditions:(NSSet *)values;
- (void)removeCourseEditions:(NSSet *)values;

@end
