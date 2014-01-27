//
//  Enrollment.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Aquirement, Course, CourseDescription, CourseEdition, Student, TeacherAquirement;

@interface Enrollment : NSManagedObject

@property (nonatomic, retain) NSSet *aquirements;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) CourseDescription *courseDescription;
@property (nonatomic, retain) NSSet *courseEditions;
@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) NSSet *teacherAquirements;
@end

@interface Enrollment (CoreDataGeneratedAccessors)

- (void)addAquirementsObject:(Aquirement *)value;
- (void)removeAquirementsObject:(Aquirement *)value;
- (void)addAquirements:(NSSet *)values;
- (void)removeAquirements:(NSSet *)values;

- (void)addCourseEditionsObject:(CourseEdition *)value;
- (void)removeCourseEditionsObject:(CourseEdition *)value;
- (void)addCourseEditions:(NSSet *)values;
- (void)removeCourseEditions:(NSSet *)values;

- (void)addTeacherAquirementsObject:(TeacherAquirement *)value;
- (void)removeTeacherAquirementsObject:(TeacherAquirement *)value;
- (void)addTeacherAquirements:(NSSet *)values;
- (void)removeTeacherAquirements:(NSSet *)values;

@end
