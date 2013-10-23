//
//  Gradation.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-23.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AquirementDescription;

@interface Gradation : NSManagedObject

@property (nonatomic, retain) NSString * levelCaption;
@property (nonatomic, retain) NSNumber * gradationLevel;
@property (nonatomic, retain) NSString * gradationCaption;
@property (nonatomic, retain) AquirementDescription *aquirementDescription;

@end
