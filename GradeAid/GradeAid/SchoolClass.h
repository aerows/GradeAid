//
//  SchoolClass.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School, Student;

@interface SchoolClass : NSManagedObject

@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSNumber * highSchool;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) NSOrderedSet *students;
@end

@interface SchoolClass (CoreDataGeneratedAccessors)

- (void)insertObject:(Student *)value inStudentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStudentsAtIndex:(NSUInteger)idx;
- (void)insertStudents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStudentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStudentsAtIndex:(NSUInteger)idx withObject:(Student *)value;
- (void)replaceStudentsAtIndexes:(NSIndexSet *)indexes withStudents:(NSArray *)values;
- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSOrderedSet *)values;
- (void)removeStudents:(NSOrderedSet *)values;
@end
