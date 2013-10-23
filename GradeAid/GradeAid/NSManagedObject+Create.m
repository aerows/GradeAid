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

@end
