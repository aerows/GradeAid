//
//  NSManagedObject+Create.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Create)

+ (BOOL) object: (NSManagedObject**) object withEntityName: (NSString*) entityName predicate: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) moc;

+ (NSNumber*) nextIDforEntityName:(NSString*) entityName idKeyPath: (NSString*) keypath managedObjectContext:(NSManagedObjectContext*) moc;

@end
