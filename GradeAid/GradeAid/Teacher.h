//
//  Teacher.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, CourseEdition, School;

@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * teacherID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *schools;
@property (nonatomic, retain) NSSet *courseEditions;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addSchoolsObject:(School *)value;
- (void)removeSchoolsObject:(School *)value;
- (void)addSchools:(NSSet *)values;
- (void)removeSchools:(NSSet *)values;

- (void)addCourseEditionsObject:(CourseEdition *)value;
- (void)removeCourseEditionsObject:(CourseEdition *)value;
- (void)addCourseEditions:(NSSet *)values;
- (void)removeCourseEditions:(NSSet *)values;

@end
