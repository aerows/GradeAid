//
//  School.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "School.h"
#import "SchoolClass.h"
#import "Teacher.h"


@implementation School

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

@dynamic name;
@dynamic schoolID;
@dynamic image;
@dynamic imageURL;
@dynamic classes;
@dynamic teachers;

@end
