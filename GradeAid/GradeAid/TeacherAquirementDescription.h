//
//  TeacherAquirementDescription.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-05.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseEdition, Teacher;

@interface TeacherAquirementDescription : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) CourseEdition *courseEdition;
@property (nonatomic, retain) Teacher *teacher;

@end
