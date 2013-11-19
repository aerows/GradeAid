//
//  Student.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Enrollment, SchoolClass;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * studentID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData   * picture;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet    * enrollments;
@property (nonatomic, retain) SchoolClass * schoolClass;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addEnrollmentsObject:(Enrollment *)value;
- (void)removeEnrollmentsObject:(Enrollment *)value;
- (void)addEnrollments:(NSSet *)values;
- (void)removeEnrollments:(NSSet *)values;

@end
