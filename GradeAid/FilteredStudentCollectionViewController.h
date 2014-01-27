//
//  FilteredStudentCollectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model
#import "Student+Create.h"
#import "Filter.h"

// Controller
#import "CollectionViewFetchedDataSource.h"

@interface FilteredStudentCollectionViewController : UICollectionViewController<CollectionViewFetchedDataSourceDelegate>

@property (nonatomic, strong) Filter *filter;
//@property (nonatomic, strong) NSArray *students;

@end
