//
//  CoreDataCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CollectionViewFetchedDataSource.h"

// Global
#import "AppDelegate.h"

@interface CollectionViewFetchedDataSource () <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fetchedResultsController;
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}
@end

@implementation CollectionViewFetchedDataSource

#pragma mark - Constructor Methods

- (id) initWithCollectionView:(UICollectionView *)collectionView fetchRequest:(NSFetchRequest *)fetchRequest delegate:(id<CollectionViewFetchedDataSourceDelegate>)delegate
{
    if (self = [super init])
    {
        _collectionView = collectionView;
        _delegate = delegate;

        [self initialize];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext sectionNameKeyPath: nil cacheName: nil];
        
        _fetchedResultsController.delegate = self;
        
        _collectionView.dataSource = self;
    }
    return self;
}

- (void) initialize
{
    _objectChanges = [NSMutableArray array];
    _sectionChanges = [NSMutableArray array];
}

#pragma mark - Public Methods

- (void) performFetch
{
    NSError *error = nil;
    [_fetchedResultsController performFetch: &error];
    if (error)
    {
        NSLog(@"%@%@", error, error.localizedDescription);
    }
    [_collectionView reloadData];
}

- (id) objectAtIndexPath:(NSIndexPath *)indexPath
{
#warning - borde göra ett par kontroller
    return [_fetchedResultsController objectAtIndexPath: indexPath];
}

#pragma mark - UICollectionVIew Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [_fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *object = [_fetchedResultsController objectAtIndexPath: indexPath];
    return [_delegate collectionViewCellForObject: object atIndexPath: indexPath];
}

#pragma mark - FetchedResultsController Methods

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
    }
    
    [_sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([_sectionChanges count] > 0)
    {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _sectionChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                    
                }];
            }
        } completion:nil];
    }
    
    if ([_objectChanges count] > 0 && [_sectionChanges count] == 0)
    {
        
        if ([self shouldReloadCollectionViewToPreventKnownIssue] || self.collectionView.window == nil) {
            // This is to prevent a bug in UICollectionView from occurring.
            // The bug presents itself when inserting the first object or deleting the last object in a collection view.
            // http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
            // This code should be removed once the bug has been fixed, it is tracked in OpenRadar
            // http://openradar.appspot.com/12954582
            [self.collectionView reloadData];
            
        } else {
            
            NSLog(@"SectionChanges: %d, ObjectChanges: %d", _sectionChanges.count, _objectChanges.count);
            
            [self.collectionView performBatchUpdates:^{
                
                for (NSDictionary *change in _objectChanges)
                {
                    [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                        
                        NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                        switch (type)
                        {
                            case NSFetchedResultsChangeInsert:
                                [self.collectionView insertItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeDelete:
                                [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeUpdate:
                                [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeMove:
                                [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                                break;
                        }
                    }];
                }
            } completion:nil];
        }
    }
    [_sectionChanges removeAllObjects];
    [_objectChanges removeAllObjects];
}

- (BOOL)shouldReloadCollectionViewToPreventKnownIssue {
    __block BOOL shouldReload = NO;
    for (NSDictionary *change in _objectChanges) {
        [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
            NSIndexPath *indexPath = obj;
            switch (type) {
                case NSFetchedResultsChangeInsert:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeDelete:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeUpdate:
                    shouldReload = NO;
                    break;
                case NSFetchedResultsChangeMove:
                    shouldReload = NO;
                    break;
            }
        }];
    }
    return shouldReload;
}

#pragma mark - Getters and Setters

@synthesize collectionView = _collectionView;
@synthesize delegate = _delegate;

- (NSFetchRequest*) fetchRequest
{
    return _fetchedResultsController.fetchRequest;
}

@end
