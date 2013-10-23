//
//  Aquirement.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-23.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AquirementDescription, Enrollment;

@interface Aquirement : NSManagedObject

@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) AquirementDescription *aquirementDescription;
@property (nonatomic, retain) Enrollment *enrollment;

@end
