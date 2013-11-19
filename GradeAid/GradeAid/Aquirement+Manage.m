//
//  Aquirement+Manage.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Aquirement+Manage.h"
#import "Gradation+Create.h"

@implementation Aquirement (Manage)

//+ (Aquirement*) createWithCourseAquirementDescription: (AquirementDescription*) aquirementDescription inManagedObjectContext: (NSManagedObjectContext*) moc
//{
//    Aquirement *aquirement = nil;
//    
//    
//    
//    aquirement.aquirementDescription = aquirementDescription;
//    
//    return aquirement;
//}
//
//+ (Aquirement*) aquirementWithAttributes: (NSDictionary*) attributes inManagedObjectContext: (NSManagedObjectContext*) moc
//{
//    Aquirement *aquirement = nil;
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: @"Aquirement"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(aquirementDescription == %@ AND enrollment == %@)",[attributes objectForKey: KeyForAquirementDescription], [attributes objectForKey: KeyForEnrollment]];
//    fetchRequest.predicate = predicate;
//    
//    NSError *error = nil;
//    
//    NSArray *response = [moc executeFetchRequest: fetchRequest error: &error];
//    
//    if (!response || response.count > 1)
//    {
//        NSLog(@"%@", error.localizedDescription);
//    }
//    else if (response.count == 1)
//    {
//        aquirement = [response lastObject];
//    }
//    else
//    {
//        aquirement = [NSEntityDescription insertNewObjectForEntityForName: @"Aquirement" inManagedObjectContext:moc];
//        aquirement.aquirementDescription = [attributes objectForKey: KeyForAquirementDescription];
//        aquirement.enrollment            = [attributes objectForKey: KeyForEnrollment];
//        aquirement.grade                 = @0;
//    }
//    
//    return aquirement;
//}

+ (Aquirement*) aquirementWithDescription:(AquirementDescription *)aquirementDescription enrollment:(Enrollment *)enrollment managedObjectContext:(NSManagedObjectContext *) moc
{
    Aquirement *aquirement = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: @"Aquirement"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(aquirementDescription == %@ AND enrollment == %@)", aquirementDescription, enrollment];
    fetchRequest.predicate = predicate;
    
    NSError *error = nil;
    
    NSArray *response = [moc executeFetchRequest: fetchRequest error: &error];
    
    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    else if (response.count == 1)
    {
        aquirement = [response lastObject];
    }
    else
    {
        aquirement = [NSEntityDescription insertNewObjectForEntityForName: @"Aquirement" inManagedObjectContext:moc];
        aquirement.aquirementDescription = aquirementDescription;
        aquirement.enrollment            = enrollment;
        aquirement.grade                 = @0;
    }
    
    return aquirement;
}


static NSString *const Separator = @"//";

- (NSArray*) keywordsForGrade: (int) grade
{
    
    Gradation *gradation;
    for (Gradation *g in self.aquirementDescription.gradations)
    {
        if ([g.gradationLevel isEqual: [NSNumber numberWithInt: grade]])
        {
            gradation = g;
            break;
        }
    }
    
    if (gradation) return [gradation.gradationCaption componentsSeparatedByString: Separator];
    
    gradation = [self.aquirementDescription.gradations anyObject];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [gradation.gradationCaption componentsSeparatedByString: Separator].count; i++) {
        [array addObject: @"..."];
    }
    return array;
    
}
- (NSAttributedString*) attributedStringForCurrentGrade:(int)grade
{
    UIColor *attributeColor = [UIColor colorWithRed: 109.f/255.f green:164.f/255.f blue:675.f/255.f alpha:1.f];
    NSArray *keyWords = [self keywordsForGrade: grade];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: self.aquirementDescription.caption];
    for (NSString *string in keyWords)
    {
        NSRange range = [attributedString.string rangeOfString: @"%@"];
        NSString *stringToInsert = [NSString stringWithFormat: @"[ %@ ]", string];
        [attributedString replaceCharactersInRange: range withAttributedString: [[NSAttributedString alloc] initWithString:stringToInsert attributes: @{NSForegroundColorAttributeName : attributeColor}]];
    }
    return attributedString;
}


@end
