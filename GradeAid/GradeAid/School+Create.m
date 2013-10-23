//
//  School+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "School+Create.h"
#import "NSManagedObject+Create.h"

@implementation School (Create)

+ (School*) schoolWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    School *school = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"schoolID = %@", [dict objectForKey: KeyForSchoolID]];

    bool objectInitalized = [NSManagedObject object: &school withEntityName: @"School" predicate: predicate inManagedObjectContext: moc];
    
    if (!objectInitalized && school)
    {
        school.name     = [dict objectForKey:  KeyForSchoolName];
        school.imageURL = [dict objectForKey:  KeyForSchoolImageURL];
        
        school.image    = UIImagePNGRepresentation([dict objectForKey: KeyForSchoolImage]);
    }
    return school;
}

+ (School*) schoolWithSchoolID: (NSNumber*) schoolID inManagedObjectContext: (NSManagedObjectContext*) moc
{

    School *school = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"schoolID = %@", schoolID];
    
    bool objectInitalized = [NSManagedObject object: &school withEntityName: @"School" predicate: predicate inManagedObjectContext: moc];
    
    if (!objectInitalized)
    {
        school.schoolID = schoolID;
    }
    return school;
}

+ (School*) createSchoolWithName: (NSString*) name image: (UIImage*) image InManagedObjectContext:(NSManagedObjectContext *) moc
{
    School *school = [NSEntityDescription insertNewObjectForEntityForName: @"School" inManagedObjectContext:moc];
    school.name = name;
    school.image = UIImagePNGRepresentation(image);
    return school;
}

+ (ObjectVerifyer*) objectVerifyer
{
    return [[SchoolObjectVerifyer alloc] init];
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed: @"school"];
}

- (UIImage*) schoolImage
{
    return ([self.image length]) ? [UIImage imageWithData: self.image] : [School defaultImage];
}

@end
