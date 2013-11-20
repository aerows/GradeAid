//
//  School.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObject.h"

@class SchoolClass, Teacher;

@interface School : ManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * schoolID;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *classes;
@property (nonatomic, retain) NSSet *teachers;
@end

@interface School (CoreDataGeneratedAccessors)

- (void)addClassesObject:(SchoolClass *)value;
- (void)removeClassesObject:(SchoolClass *)value;
- (void)addClasses:(NSSet *)values;
- (void)removeClasses:(NSSet *)values;

- (void)addTeachersObject:(Teacher *)value;
- (void)removeTeachersObject:(Teacher *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

@end
