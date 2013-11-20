//
//  HomeViewController.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataCollectionViewController.h"
#import "CollectionViewDataFetcher.h"
#import "School+Create.h"

@interface SchoolCollectionViewController :  UIViewController<UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *schoolCollectionView;

@property (nonatomic, strong) CollectionViewDataFetcher *schoolDataFetcher;
@property (nonatomic, strong) NSFetchedResultsController *schoolDataFetchController;

@end
