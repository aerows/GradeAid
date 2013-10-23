//
//  Course.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObject.h"

@class CourseDescription, Enrollment, SchoolClass, Teacher;

@interface Course : ManagedObject

@property (nonatomic, retain) CourseDescription *courseDescription;
@property (nonatomic, retain) NSSet *enrollments;
@property (nonatomic, retain) SchoolClass *schoolClass;
@property (nonatomic, retain) Teacher *teacher;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addEnrollmentsObject:(Enrollment *)value;
- (void)removeEnrollmentsObject:(Enrollment *)value;
- (void)addEnrollments:(NSSet *)values;
- (void)removeEnrollments:(NSSet *)values;

@end
