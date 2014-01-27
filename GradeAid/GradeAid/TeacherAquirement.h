//
//  TeacherAquirement.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Enrollment, TeacherAquirementDescription;

@interface TeacherAquirement : NSManagedObject

@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) TeacherAquirementDescription *teacherAquirementDescription;
@property (nonatomic, retain) Enrollment *enrollment;

@end
