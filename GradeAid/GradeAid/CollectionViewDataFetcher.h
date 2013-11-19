//
//  CollectionViewDataFetcher.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CollectionViewDataFetcher : NSObject<UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

- (id) initWithFetchedResultsController: (NSFetchedResultsController*) frc collectionView: (UICollectionView*) cv cellBlock: (UICollectionViewCell*(^)(UICollectionView*,NSIndexPath*)) block;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy)   UICollectionViewCell* (^createCellBlock)(UICollectionView *,NSIndexPath *);

@end
