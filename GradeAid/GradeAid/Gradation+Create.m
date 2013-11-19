//
//  Gradation+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-23.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "Gradation+Create.h"
#import "NSManagedObject+Create.h"
#import "AquirementDescription.h"

@implementation Gradation (Create)

+ (Gradation*) gradationWithDict:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)moc
{

    Gradation *gradation = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(gradationLevel = %@ AND aquirementDescription = %@)", [dict objectForKey: KeyForGradationLevel], [dict objectForKey: KeyForGradeAquirementDescription]];
    
    bool objectInitalized = [NSManagedObject object: &gradation withEntityName: @"Gradation" predicate: predicate inManagedObjectContext: moc];
    
    if (!objectInitalized && gradation)
    {
        gradation.gradationCaption  = [dict objectForKey: KeyForGradationCaption];
        gradation.gradationLevel    = [dict objectForKey: KeyForGradationLevel];
        gradation.levelCaption      = [dict objectForKey: KeyForLevelCaption];
    }
    return gradation;
}

@end
