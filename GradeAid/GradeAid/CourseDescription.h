//
//  CourseDescription.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-23.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AquirementDescription, CourseCentralContent, Subject;

@interface CourseDescription : NSManagedObject

@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSNumber * credits;
@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * scope;
@property (nonatomic, retain) NSNumber * subjectID;
@property (nonatomic, retain) NSSet *aquirementDescriptions;
@property (nonatomic, retain) NSSet *centralContentItems;
@property (nonatomic, retain) Subject *subject;
@end

@interface CourseDescription (CoreDataGeneratedAccessors)

- (void)addAquirementDescriptionsObject:(AquirementDescription *)value;
- (void)removeAquirementDescriptionsObject:(AquirementDescription *)value;
- (void)addAquirementDescriptions:(NSSet *)values;
- (void)removeAquirementDescriptions:(NSSet *)values;

- (void)addCentralContentItemsObject:(CourseCentralContent *)value;
- (void)removeCentralContentItemsObject:(CourseCentralContent *)value;
- (void)addCentralContentItems:(NSSet *)values;
- (void)removeCentralContentItems:(NSSet *)values;

@end
