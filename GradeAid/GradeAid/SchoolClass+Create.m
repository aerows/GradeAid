//
//  SchoolClass+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClass+Create.h"
#import "SchoolClassObjectVerifyer.h"
#import "School+Create.h"

@implementation SchoolClass (Create)


+ (ObjectVerifyer*) objectVerifyer
{
    return [[SchoolClassObjectVerifyer alloc] init];
}

+ (SchoolClass*) createSchoolClassWithAttributes:(NSDictionary *) attributes InManagedObjectContext:(NSManagedObjectContext *)moc
{
    SchoolClass *schoolClass = [NSEntityDescription insertNewObjectForEntityForName: @"SchoolClass" inManagedObjectContext:moc];
    
    
    schoolClass.name = [attributes objectForKey: KeyForSchoolClassName];
    schoolClass.year = [attributes objectForKey: KeyForSchoolClassYear];

    schoolClass.school = [School schoolWithSchoolID: [attributes objectForKey: KeyForSchoolID] inManagedObjectContext: moc];
    
    return schoolClass;
}

@end
