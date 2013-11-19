//
//  CourseCollectionViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewDataFetcher.h"
#import "CourseDescription+Create.h"
#import "CourseEdition+Create.h"
#import "Course+Create.h"

@interface CourseCollectionViewController : UIViewController<UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *courseCollectionView;

@end
