//
//  CoreDataCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-09.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CoreDataCollectionViewController.h"

@interface CoreDataCollectionViewController ()

@end

@implementation CoreDataCollectionViewController

#pragma mark - UICollectionView DataSource Methods

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

#pragma mark - NSFetchedResults Delegate Method

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView reloadData];
}

#pragma mark - Getters and Setters

@synthesize fetchedResultsController = _fetchedResultsController;

- (void) setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    [_fetchedResultsController setDelegate: self];
    [_fetchedResultsController performFetch: nil];
}

@end
