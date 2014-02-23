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

// View
#import "GraidAidCollectionViewCell.h"

// Controller
#import "CollectionViewFetchedDataSource.h"

#import "Student+Create.h"

static NSString *const FilteredStudentCollectionViewControllerDidEnterEditModeNotification = @"FilteredStudentCollectionViewControllerDidEnterEditModeNotification";

static NSString *const StudentGradeAidCollectionViewCell = @"StudentGradeAidCollectionViewCell";

@interface FilteredStudentCollectionViewController : UICollectionViewController<CollectionViewFetchedDataSourceDelegate>

@property (nonatomic) BOOL editMode;
@property (nonatomic, strong) Filter *filter;

@end
