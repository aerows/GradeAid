//
//  Subject.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseDescription, SubjectObjective;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * introCaption;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectiveCaption;
@property (nonatomic, retain) NSNumber * subjectID;
@property (nonatomic, retain) NSString * objectiveItemHeader;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *objectives;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(CourseDescription *)value;
- (void)removeCoursesObject:(CourseDescription *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addObjectivesObject:(SubjectObjective *)value;
- (void)removeObjectivesObject:(SubjectObjective *)value;
- (void)addObjectives:(NSSet *)values;
- (void)removeObjectives:(NSSet *)values;

@end
