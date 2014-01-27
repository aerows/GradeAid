//
//  FilteredCourseCollectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"

// Controller
#import "CollectionViewFetchedDataSource.h"

@interface FilteredCourseCollectionViewController : UICollectionViewController<CollectionViewFetchedDataSourceDelegate>

@property (nonatomic, strong) Filter *filter;

@end
