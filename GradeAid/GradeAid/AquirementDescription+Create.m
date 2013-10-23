//
//  AquirementDescription+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AquirementDescription+Create.h"
#import "NSManagedObject+Create.h"
#import "Gradation+Create.h"

static NSString *const KeyForCourseID = @"courseID";

@implementation AquirementDescription (Create)

+ (AquirementDescription*) descriptionWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc
{
    AquirementDescription *aquiDesc = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(courseID = %@ AND aquirementDescriptionID = %@)",
                              [dict objectForKey: KeyForCourseID],
                              [dict objectForKey: KeyForAquirementDescID]];
    
    bool objectInitalized = [NSManagedObject object: &aquiDesc withEntityName: @"AquirementDescription" predicate: predicate inManagedObjectContext: moc];
    
    if (!objectInitalized && aquiDesc)
    {
        aquiDesc.sectionTitle               = [dict objectForKey: KeyForSectionTitle];
        aquiDesc.caption                    = [dict objectForKey: KeyForCaption];
        aquiDesc.nrOfGradations             = [dict objectForKey: KeyForNrOfGradations];
        aquiDesc.courseID                   = [dict objectForKey: KeyForCourseID];
        aquiDesc.aquirementDescriptionID    = [dict objectForKey: KeyForAquirementDescID];
        aquiDesc.nrOfGradations             = [dict objectForKey: KeyForNrOfGradations];
        aquiDesc.caption                    = [dict objectForKey: KeyForCaption];
        
        /* Temporary solution before database gets updated */
        NSArray *gradations = @[[dict objectForKey: KeyForE_Caption],
                                [dict objectForKey: KeyForC_Caption],
                                [dict objectForKey: KeyForA_Caption]];
        NSArray *gradationLevels = @[@1,@2,@3];
        NSArray *levelCaption    = @[@"E",@"C",@"A"];
        
        for (int i = 0; i < gradations.count; i++)
        {
            NSDictionary *gradDict = @{KeyForGradationCaption : [gradations objectAtIndex: i],
                                       KeyForGradationLevel   : [gradationLevels objectAtIndex: i],
                                       KeyForLevelCaption     : [levelCaption objectAtIndex: i],
                                       KeyForAquirementDescription : aquiDesc};
            
            [aquiDesc addGradationsObject: [Gradation gradationWithDict: gradDict inManagedObjectContext:moc]];
        }
    }
    return aquiDesc;
}
//+ (AquirementDescription*) _descriptionWithDict:(NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext*) moc
//    {
//    AquirementDescription *desc = nil;
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"CourseAquirementDescription"];
//    request.predicate = [NSPredicate predicateWithFormat: @"(courseID = %@ AND aquirementDescriptionID = %@)",
//                         [dict objectForKey: KeyForCourseID],
//                         [dict objectForKey: KeyForAquirementDescID]];
//    
//    NSError *error;
//    NSArray *response = [moc executeFetchRequest:request error:&error];
//    
//    if (!response || response.count > 1)
//    {
//        NSLog(@"%@", error.description);
//    }
//    else if (response.count == 1)
//    {
//        desc = [response lastObject];
//    }
//    else
//    {
//        desc = [NSEntityDescription insertNewObjectForEntityForName: @"AquirementDescription" inManagedObjectContext:moc];
//        
//        desc.sectionTitle               = [dict objectForKey: KeyForSectionTitle];
//        desc.caption                    = [dict objectForKey: KeyForCaption];
//        desc.nrOfGradations             = [dict objectForKey: KeyForNrOfGradations];
//        desc.courseID                   = [dict objectForKey: KeyForCourseID];
//        desc.aquirementDescriptionID    = [dict objectForKey: KeyForAquirementDescID];
//        desc.nrOfGradations             = [dict objectForKey: KeyForNrOfGradations];
//        desc.caption                    = [dict objectForKey: KeyForCaption];     
//    }
//    
//    return desc;
//}

static NSString *const Separator = @"//";

- (NSArray*) keywordsForGrade: (int) grade
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    switch (grade) {
//        case 0:
//        {
//            for (int i = 0; i < [self.aCaption componentsSeparatedByString: Separator].count; i++) {
//                [array addObject: @"..."];
//            }
//            break;
//        }
//        case 1: [array setArray: [self.eCaption componentsSeparatedByString: Separator]]; break;
//        case 2: [array setArray: [self.cCaption componentsSeparatedByString: Separator]]; break;
//        case 3: [array setArray: [self.aCaption componentsSeparatedByString: Separator]]; break;
//        default: break;
//    }
    return array;
}
- (NSAttributedString*) attributedStringForCurrentGrade:(int)grade
{
    UIColor *attributeColor = [UIColor colorWithRed: 109.f/255.f green:164.f/255.f blue:675.f/255.f alpha:1.f];
    NSArray *keyWords = [self keywordsForGrade: grade];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: self.caption];
    for (NSString *string in keyWords)
    {
        NSRange range = [attributedString.string rangeOfString: @"%@"];
        NSString *stringToInsert = [NSString stringWithFormat: @"[ %@ ]", string];
        [attributedString replaceCharactersInRange: range withAttributedString: [[NSAttributedString alloc] initWithString:stringToInsert attributes: @{NSForegroundColorAttributeName : attributeColor}]];
    }
    return attributedString;
}
//
//static NSString *const Separator = @"//";
//
//- (NSArray*) keywordsForGrade: (int) grade
//{
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    switch (grade) {
//        case 0:
//        {
//            for (int i = 0; i < [self.aCaption componentsSeparatedByString: Separator].count; i++) {
//                [array addObject: @"..."];
//            }
//            break;
//        }
//        case 1: [array setArray: [self.eCaption componentsSeparatedByString: Separator]]; break;
//        case 2: [array setArray: [self.cCaption componentsSeparatedByString: Separator]]; break;
//        case 3: [array setArray: [self.aCaption componentsSeparatedByString: Separator]]; break;
//        default: break;
//    }
//    return array;
//}

@end
