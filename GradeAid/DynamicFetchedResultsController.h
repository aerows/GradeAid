//
//  DynamicFetchedResultsController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-26.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DynamicFetchedResultsControllerDelegate <NSObject>



@end

@interface DynamicFetchedResultsController : NSFetchedResultsController

@property (nonatomic) NSInteger sectionIndexOffset;
@property (nonatomic) NSRange sectionRange;

@end
