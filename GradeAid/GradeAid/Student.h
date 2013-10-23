//
//  Student.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"

@class Enrollment, SchoolClass;

@interface Student : Person

@property (nonatomic, retain) NSNumber * studentID;
@property (nonatomic, retain) NSSet *enrollments;
@property (nonatomic, retain) SchoolClass *schoolClass;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addEnrollmentsObject:(Enrollment *)value;
- (void)removeEnrollmentsObject:(Enrollment *)value;
- (void)addEnrollments:(NSSet *)values;
- (void)removeEnrollments:(NSSet *)values;

@end
