//
//  Student+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "NSManagedObject+Create.h"
#import "Student+Create.h"
#import "School+Create.h"
#import "SchoolClass+Create.h"

@implementation Student (Create)

+ (Student*) studentWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    Student *student = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"studentID = %@", [dict objectForKey: StudentKeyForStudentID]];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        student = [response lastObject];
    }
    else
    {
        NSNumber *studentID = [NSManagedObject nextIDforEntityName: @"Student" idKeyPath: @"studentID" managedObjectContext: moc];
        
        student = [NSEntityDescription insertNewObjectForEntityForName: @"Student" inManagedObjectContext:moc];
        
        student.firstName   = [dict objectForKey: StudentKeyForFirstName];
        student.lastName    = [dict objectForKey: StudentKeyForLastName];
        student.email       = [dict objectForKey: StudentKeyForEmail];
        
        student.picture       = UIImagePNGRepresentation([dict objectForKey: StudentKeyForPicture]);
        
        student.schoolClass = [dict objectForKey: StudentKeyForSchoolClass];
        
        student.studentID = studentID;

    }
    return student;
}

- (NSString*) title
{
    return [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
}

- (UIImage*) thumbNail
{
    return [UIImage imageNamed: @"student.jpg"];
}

+ (ObjectVerifyer*) objectVerifyer
{
//    NSArray *orderedAttributeKeys = @[KeyForFirstName, KeyForLastName, KeyForEmail];
//    
//    __block AttributeInput *studentFirstName = [AttributeInput nameAttribute];
//    studentFirstName.attributeTitle = @"Förnamn";
//    studentFirstName.attributeExample = @"Förnamn...";
//    
//    __block AttributeInput *studentLastName = [AttributeInput nameAttribute];
//    studentLastName.attributeTitle = @"Efternamn";
//    studentLastName.attributeExample = @"Efternamn...";
//    
//    __block AttributeInput *studentEmail = [AttributeInput nameAttribute]; // Skall vara epostAttribute
//    studentLastName.attributeTitle = @"Epost";
//    studentLastName.attributeExample = @"namn@mail.se...";
//    
//    
//    NSDictionary *attributes = @{   KeyForFirstName : studentFirstName,
//                                    KeyForLastName  : studentLastName,
//                                    KeyForEmail     : studentEmail};
//    
//    NSArray *orderedSelectionKeys = @[KeyForSchoolClass];
//    
//    __block SellectionVerifyer *schoolSelection = [[SellectionVerifyer alloc] initWithArray: [School schoolsForCurrentTeacher]];
//    
//    NSDictionary *selectors = @{KeyForSchool : schoolSelection};
//    
//    
//    void(^completion)(NSDictionary*, NSManagedObjectContext*);
//    completion = ^(NSDictionary *attributes, NSManagedObjectContext *moc) {
//        
//        NSMutableDictionary *atr = [[NSMutableDictionary alloc] initWithDictionary:
//                                    @{KeyForSchoolClassName : schoolClassName.value,
//                                      KeyForSchoolClassYear : @(schoolClassYear.value.intValue)}];
//        if (schoolSelection.value)
//        {
//            [atr setObject: ((School*)schoolSelection.value).schoolID forKey: KeyForSchoolID];
//        }
//        [SchoolClass createSchoolClassWithAttributes: atr InManagedObjectContext: moc];
//        
//    };
//    
//    return [[ObjectVerifyer alloc] initWithAttributes: attributes
//                                          orderedKeys: orderedAttributeKeys
//                                           sellectors: selectors
//                                        sellectorKeys: orderedSelectionKeys
//                                           completion: completion];
    NSLog(@"Not using objectVerifyers more");
    return nil;
}

#pragma mark - Image Methods

- (UIImage*) studentImage
{
#warning - Databas lägg till image för student
    
    return [Student defaultImage];
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed: @"default-student"];
}

@end
