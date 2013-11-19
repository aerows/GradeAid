//
//  AquirementDescription.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-28.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDescription, Gradation;

@interface AquirementDescription : NSManagedObject

@property (nonatomic, retain) NSNumber * aquirementDescriptionID;
@property (nonatomic, retain) NSNumber * aquirementType;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSNumber * nrOfGradations;
@property (nonatomic, retain) NSString * sectionTitle;
@property (nonatomic, retain) NSString * sectionIndex;
@property (nonatomic, retain) CourseDescription *course;
@property (nonatomic, retain) NSSet *gradations;
@end

@interface AquirementDescription (CoreDataGeneratedAccessors)

- (void)addGradationsObject:(Gradation *)value;
- (void)removeGradationsObject:(Gradation *)value;
- (void)addGradations:(NSSet *)values;
- (void)removeGradations:(NSSet *)values;

@end
