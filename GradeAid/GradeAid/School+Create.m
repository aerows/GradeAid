//
//  School+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-14.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "School+Create.h"
#import "NSManagedObject+Create.h"
#import "Session.h"

@implementation School (Create)

+ (School*) schoolWithDict: (NSDictionary*) dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    School *school = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"School"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"schoolID = %@", [dict objectForKey: KeyForSchoolID]];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
    }
    else if (response.count == 1)
    {
        school = [response lastObject];
    }
    else
    {
        NSNumber *schoolID = [NSManagedObject nextIDforEntityName: @"School" idKeyPath: @"schoolID" managedObjectContext: moc];
        
        school = [NSEntityDescription insertNewObjectForEntityForName: @"School" inManagedObjectContext:moc];

        
        school.schoolID = schoolID;
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

+ (NSArray*) schoolsForCurrentTeacher
{
    Teacher *currentTeacher = [Session currentSession].teacher;
    NSArray *schools = @[];
    if (currentTeacher.schools.count)
    {
        NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES];
        schools = [[currentTeacher.schools allObjects] sortedArrayUsingDescriptors:@[sortDesc]];
    }
    return schools;
}

+ (UIImage*) defaultImage
{
    return [UIImage imageNamed: @"default-school"];
}

- (UIImage*) schoolImage
{
    return (self.image) ? [UIImage imageWithData: self.image] : [School defaultImage];
}

#pragma mark - CellPresentable Methods

- (UIImage*) thumbNail
{
    return ([self.image length]) ? [UIImage imageWithData: self.image] : [School defaultImage];
}

- (NSString*) title
{
    return self.name;
}

#pragma mark - Creatable Methods

+ (ObjectVerifyer*) objectVerifyer
{
    
    AttributeInput *schoolNameInput = [AttributeInput nameAttribute];
    schoolNameInput.attributeTitle = @"Namn";
    schoolNameInput.attributeExample = @"Skolans namn...";
    
    NSArray *orderedAttributeKeys = @[KeyForSchoolName];
    
    NSDictionary *attributes = @{   KeyForSchoolName : schoolNameInput };
    
    void(^completion)(NSDictionary*,NSManagedObjectContext*) = ^(NSDictionary *attributes, NSManagedObjectContext *moc)
    {
        School *newSchool = [School schoolWithDict: attributes inManagedObjectContext:moc];
        Teacher *currentTeacher = [Session currentSession].teacher;
        [currentTeacher addSchoolsObject: newSchool];
    };
    
    return [[ObjectVerifyer alloc] initWithAttributes: attributes
                                          orderedKeys: orderedAttributeKeys
                                           completion: completion];
}

#pragma mark - Helper Methods

//+ (NSNumber*) nextIDforSchoolInManagedObjectContext: (NSManagedObjectContext*) moc
//{
//    NSNumber *nextID = nil;
//
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity: [NSEntityDescription entityForName:@"School" inManagedObjectContext: moc]];
//    [request setResultType:NSDictionaryResultType];
//    
//    NSExpression *keyPathExpression = [NSExpression
//                                       expressionForKeyPath:@"schoolID"];
//    NSExpression *earliestExpression = [NSExpression
//                                        expressionForFunction:@"max:"
//                                        arguments:[NSArray arrayWithObject:keyPathExpression]];
//
//    NSExpressionDescription *highestExpressionDescription =
//    
//    [[NSExpressionDescription alloc] init];
//    [highestExpressionDescription setName:@"highestID"];
//    [highestExpressionDescription setExpression:earliestExpression];
//    [highestExpressionDescription setExpressionResultType:NSInteger16AttributeType];
//
//    [request setPropertiesToFetch:[NSArray arrayWithObject:
//                                        highestExpressionDescription]];
//    NSError *error = nil;
//    NSArray *response = [moc executeFetchRequest:request error:&error];
//    
//    nextID = [[response lastObject] valueForKey:@"highestID"];
//
//    if (nextID)
//    {
//        nextID = @(nextID.intValue + 1);
//    }
//    else
//    {
//        nextID = @0;
//    }
//    
//    return nextID; 
//}

@end
