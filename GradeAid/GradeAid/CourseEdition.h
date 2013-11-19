//
//  CourseEdition.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AquirementDescription, CourseDescription, Teacher;

@interface CourseEdition : NSManagedObject

@property (nonatomic, retain) NSSet *aquirementDescriptions;
@property (nonatomic, retain) CourseDescription *courseDescription;
@property (nonatomic, retain) Teacher *teacher;
@end

@interface CourseEdition (CoreDataGeneratedAccessors)

- (void)addAquirementDescriptionsObject:(AquirementDescription *)value;
- (void)removeAquirementDescriptionsObject:(AquirementDescription *)value;
- (void)addAquirementDescriptions:(NSSet *)values;
- (void)removeAquirementDescriptions:(NSSet *)values;

@end
