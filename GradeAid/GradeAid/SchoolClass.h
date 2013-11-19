//
//  SchoolClass.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, School, Student;

@interface SchoolClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSSet *course;
@end

@interface SchoolClass (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

- (void)addCourseObject:(Course *)value;
- (void)removeCourseObject:(Course *)value;
- (void)addCourse:(NSSet *)values;
- (void)removeCourse:(NSSet *)values;

@end
