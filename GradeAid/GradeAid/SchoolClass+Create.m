//
//  SchoolClass+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClass+Create.h"
#import "School+Create.h"

@implementation SchoolClass (Create)

+ (SchoolClass*) createSchoolClassWithAttributes:(NSDictionary *) attributes InManagedObjectContext:(NSManagedObjectContext *)moc
{
    SchoolClass *schoolClass = [NSEntityDescription insertNewObjectForEntityForName: @"SchoolClass" inManagedObjectContext:moc];
    
    
    schoolClass.name = [attributes objectForKey: KeyForSchoolClassName];
    schoolClass.year = [attributes objectForKey: KeyForSchoolClassYear];

    schoolClass.school = [School schoolWithSchoolID: [attributes objectForKey: KeyForSchoolID] inManagedObjectContext: moc];
    
    return schoolClass;
}

- (NSString*) title
{
    return self.name;
}

- (UIImage*) thumbNail
{
    return [UIImage imageNamed: @"schoolclass"];
}

+ (NSArray*) schoolClassesForCurrentTeacher
{
    NSMutableArray *classes = [[NSMutableArray alloc] init];
    for (School *school in [School schoolsForCurrentTeacher])
    {
        [classes addObjectsFromArray: [school.classes allObjects]];
    }
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES];
    [classes sortUsingDescriptors: @[sortDesc]];
    
    return classes;
}

+ (NSArray*) schoolClassesForSchool: (School*) school
{
    NSArray *classes = @[];
    if (school.classes.count)
    {
        NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES];
        classes = [[school.classes allObjects] sortedArrayUsingDescriptors:@[sortDesc]];
    }
    return classes;
}

+ (ObjectVerifyer*) objectVerifyer
{
    NSArray *orderedAttributeKeys = @[KeyForSchoolClassName, KeyForSchoolClassYear];
    
    __block AttributeInput *schoolClassName = [AttributeInput nameAttribute];
    schoolClassName.attributeTitle = @"Klassnamn";
    schoolClassName.attributeExample = @"Klassens namn...";
    
    __block AttributeInput *schoolClassYear = [AttributeInput nameAttribute]; // Skall vara numberAttribute
    schoolClassYear.attributeTitle = @"Årskull";
    schoolClassYear.attributeExample = @"T.ex. 1, 6, 9...";
    
    NSDictionary *attributes = @{   KeyForSchoolClassName : schoolClassName,
                                    KeyForSchoolClassYear : schoolClassYear};
    
    NSArray *orderedSelectionKeys = @[KeyForSchool];
    
    __block SellectionVerifyer *schoolSelection = [[SellectionVerifyer alloc] initWithArray: [School schoolsForCurrentTeacher]];
    
    NSDictionary *selectors = @{KeyForSchool : schoolSelection};
    
    
    void(^completion)(NSDictionary*, NSManagedObjectContext*);
    completion = ^(NSDictionary *attributes, NSManagedObjectContext *moc) {
        
        NSMutableDictionary *atr = [[NSMutableDictionary alloc] initWithDictionary:
                            @{KeyForSchoolClassName : schoolClassName.value,
                              KeyForSchoolClassYear : @(schoolClassYear.value.intValue)}];
        if (schoolSelection.value)
        {
            [atr setObject: ((School*)schoolSelection.value).schoolID forKey: KeyForSchoolID];
        }
        [SchoolClass createSchoolClassWithAttributes: atr InManagedObjectContext: moc];
        
    };
    
    return [[ObjectVerifyer alloc] initWithAttributes: attributes
                                          orderedKeys: orderedAttributeKeys
                                           sellectors: selectors
                                        sellectorKeys: orderedSelectionKeys
                                           completion: completion];
}

- (NSArray*) sortedStudents
{
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"lastName" ascending: YES];
    NSArray *sortedStudents = [[self.students allObjects] sortedArrayUsingDescriptors: @[sortDesc]];
    return sortedStudents;
}

#pragma mark - Image Methods

- (UIImage*) schoolClassImage
{
    return [SchoolClass defaultImage];
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed: @"default-schoolclass"];
}

@end
