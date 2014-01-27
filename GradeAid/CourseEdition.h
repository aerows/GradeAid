//
//  CourseEdition.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDescription, Teacher, TeacherAquirementDescription;

@interface CourseEdition : NSManagedObject

@property (nonatomic, retain) NSSet *teacherAquirementDescriptions;
@property (nonatomic, retain) CourseDescription *courseDescription;
@property (nonatomic, retain) Teacher *teacher;
@end

@interface CourseEdition (CoreDataGeneratedAccessors)

- (void)addTeacherAquirementDescriptionsObject:(TeacherAquirementDescription *)value;
- (void)removeTeacherAquirementDescriptionsObject:(TeacherAquirementDescription *)value;
- (void)addTeacherAquirementDescriptions:(NSSet *)values;
- (void)removeTeacherAquirementDescriptions:(NSSet *)values;

@end
