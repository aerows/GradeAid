//
//  SchoolClass+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClass+Create.h"
#import "School+Create.h"
#import "AppDelegate.h"

@implementation SchoolClass (Create)

+ (SchoolClass*) createSchoolClassWithAttributes:(NSDictionary *) attributes InManagedObjectContext:(NSManagedObjectContext *)moc
{
    SchoolClass *schoolClass = [NSEntityDescription insertNewObjectForEntityForName: @"SchoolClass" inManagedObjectContext:moc];
    
    
    schoolClass.suffix = [attributes objectForKey: KeyForSchoolClassName];
    schoolClass.year = [attributes objectForKey: KeyForSchoolClassYear];

    schoolClass.school = [School schoolWithSchoolID: [attributes objectForKey: KeyForSchoolID] inManagedObjectContext: moc];
    
    return schoolClass;
}

+ (SchoolClass*) schoolClassWithSchool: (School*) school year: (NSNumber*) year suffix: (NSString*) suffix highschool: (NSNumber*) isHighschool managedObjectContext: (NSManagedObjectContext*) moc
{
    SchoolClass *schoolClass = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"SchoolClass"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(school = %@ AND year = %@ AND suffix = %@ AND highSchool = %@)",
                              school, year, suffix, isHighschool];
    request.predicate = predicate;

    NSError *error = nil;

    NSArray *response = [moc executeFetchRequest: request error: &error];

    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    else if (response.count == 1)
    {
        schoolClass = [response lastObject];
    }
    else
    {
        schoolClass = [NSEntityDescription insertNewObjectForEntityForName: @"SchoolClass" inManagedObjectContext: moc];
        schoolClass.school = school;
        schoolClass.year = year;
        schoolClass.suffix = suffix;
        schoolClass.highSchool = isHighschool;
    }

    return schoolClass;
}

- (NSString*) title
{
    return [NSString stringWithFormat: @"%@ %@%@", self.school.title, self.year, self.suffix];
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
        NSSortDescriptor *yearSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"year" ascending: YES];
        NSSortDescriptor *suffixSortDesc = [NSSortDescriptor sortDescriptorWithKey: @"suffix" ascending: YES];
        classes = [[school.classes allObjects] sortedArrayUsingDescriptors:@[yearSortDesc, suffixSortDesc]];
    }
    return classes;
}

- (NSArray*) sortedStudents
{
//    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"lastName" ascending: YES];
    return [self.students array];
}

- (NSString*) schoolClassName
{
    return [NSString stringWithFormat: @"%@%@", self.year, self.suffix];
}

- (NSString*) fullSchoolClassName
{
    return [NSString stringWithFormat: @"%@ %@%@", self.school.name, self.year, self.suffix];
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

+ (BOOL) deleteSchoolClass:(SchoolClass *)schoolClass
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    [moc deleteObject: schoolClass];
    return [moc save: nil];
}


@end
