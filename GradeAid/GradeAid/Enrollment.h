//
//  Enrollment.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObject.h"

@class Aquirement, Course, Student;

@interface Enrollment : ManagedObject

@property (nonatomic, retain) NSSet *aquirements;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) Student *student;
@end

@interface Enrollment (CoreDataGeneratedAccessors)

- (void)addAquirementsObject:(Aquirement *)value;
- (void)removeAquirementsObject:(Aquirement *)value;
- (void)addAquirements:(NSSet *)values;
- (void)removeAquirements:(NSSet *)values;

@end
