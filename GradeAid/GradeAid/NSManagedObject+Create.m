//
//  NSManagedObject+Create.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "NSManagedObject+Create.h"

@implementation NSManagedObject (Create)

+ (BOOL) object: (NSManagedObject**) object withEntityName: (NSString*) entityName predicate: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) moc
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: entityName];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *response = [moc executeFetchRequest:request error: &error];

    if (!response || response.count > 1)
    {
        NSLog(@"%@", error.description);
        return NO;
    }
    else if (response.count == 1)
    {
        *object = [response lastObject];
        return YES;
    }
    else
    {
        *object = [NSEntityDescription insertNewObjectForEntityForName: entityName inManagedObjectContext:moc];
        return NO;
    }
}

+ (NSNumber*) nextIDforEntityName:(NSString*) entityName idKeyPath: (NSString*) keypath managedObjectContext:(NSManagedObjectContext*) moc
{
    NSNumber *nextID = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity: [NSEntityDescription entityForName: entityName inManagedObjectContext: moc]];
    [request setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression
                                       expressionForKeyPath: keypath];
    NSExpression *earliestExpression = [NSExpression
                                        expressionForFunction:@"max:"
                                        arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    NSExpressionDescription *highestExpressionDescription =
    
    [[NSExpressionDescription alloc] init];
    [highestExpressionDescription setName:@"highestID"];
    [highestExpressionDescription setExpression:earliestExpression];
    [highestExpressionDescription setExpressionResultType:NSInteger16AttributeType];
    
    [request setPropertiesToFetch:[NSArray arrayWithObject:
                                   highestExpressionDescription]];
    NSError *error = nil;
    NSArray *response = [moc executeFetchRequest:request error:&error];
    
    nextID = [[response lastObject] valueForKey:@"highestID"];
    
    if (nextID)
    {
        nextID = @(nextID.intValue + 1);
    }
    else
    {
        nextID = @0;
    }
    
    return nextID;
}

@end
