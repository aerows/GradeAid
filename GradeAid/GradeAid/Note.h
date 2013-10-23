//
//  Note.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-25.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObject.h"

@class Media;

@interface Note : ManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet *media;
@end

@interface Note (CoreDataGeneratedAccessors)

- (void)addMediaObject:(Media *)value;
- (void)removeMediaObject:(Media *)value;
- (void)addMedia:(NSSet *)values;
- (void)removeMedia:(NSSet *)values;

@end
