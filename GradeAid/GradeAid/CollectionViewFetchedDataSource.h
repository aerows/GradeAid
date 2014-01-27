//
//  CollectionViewFetchedDataSource.h
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewFetchedDataSourceDelegate <NSObject>

- (UICollectionViewCell*) collectionViewCellForObject: (NSObject*) object atIndexPath: (NSIndexPath*) indexPath;

@end

@interface CollectionViewFetchedDataSource : UICollectionViewController<UICollectionViewDataSource>

- (id) initWithCollectionView: (UICollectionView*) collectionView fetchRequest: (NSFetchRequest*) fetchRequest delegate: (id<CollectionViewFetchedDataSourceDelegate>) delegate;
- (void) performFetch;

- (id) objectAtIndexPath: (NSIndexPath*) indexPath;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSFetchRequest *fetchRequest;
@property (nonatomic, assign) id<CollectionViewFetchedDataSourceDelegate> delegate;

@end
