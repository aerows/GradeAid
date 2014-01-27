//
//  FilteredCollectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"

@interface FilteredCollectionViewController : UICollectionViewController
{
    Filter *_filter;
}

@property (nonatomic, strong) Filter *filter;

- (void) filterDidUpdate:(NSNotification*) notification;
- (void) setupWithFilter;

@end
