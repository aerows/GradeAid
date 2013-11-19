//
//  SellectionVerifyer.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-06.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SellectionVerifyer.h"
#import "CollectionViewDataFetcher.h"
#import "PopupCell.h"
#import "CellPresentable.h"

@interface  SellectionVerifyer ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SellectionVerifyer

#pragma mark - Constructor Methods

- (id) initWithArray:(NSArray *)objects
{
    if (self = [super init])
    {
        _objects = objects;
        if (_objects.count == 1)
        {
            _selectedObject = [_objects lastObject];
        }
    }
    return self;
}

- (id) initWithFetchRequest:(NSFetchRequest *)fetchRequest managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (self = [super init])
    {
        _managedObjectContext = managedObjectContext;
        _fetchRequest = fetchRequest;
    }
    return self;
}

- (void) initialize
{
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: _fetchRequest managedObjectContext: _managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    [_fetchedResultsController performFetch: nil];
}

#pragma mark - UICollectionView Datasource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PopupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: PopupCellIdentifier forIndexPath:indexPath];
    id<CellPresentable> object = [_objects objectAtIndex: indexPath.row];
    
    cell.thumbNail = [object thumbNail];
    cell.title = [object title];
    
    return cell;
}

#pragma mark - UITableView Datasource Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CellIdentifier = @"CellIdentifier";
    __block UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    __block NSManagedObject* object = (NSManagedObject*)[_objects objectAtIndex: indexPath.item];
    _setupTableViewCell(cell, object);
    return cell;
}

#pragma mark - UICollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectedObjectAtIndexPath: indexPath];
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectedObjectAtIndexPath: indexPath];
}

#pragma mark - Helper Methods

- (void) selectedObjectAtIndexPath: (NSIndexPath*) indexPath
{
    _selectedObject = [_objects objectAtIndex: indexPath.row];
    [_view updateView];
    [_delegate updateSellectionVerifyerDelegate];
}

#pragma mark - Getters and Setters

@synthesize fetchRequest = _fetchRequest;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize objects = _objects;

@synthesize attributeTitle = _attributeTitle;
@synthesize value = _value;
@synthesize selectedObject = _selectedObject;
@synthesize verified = _verified;

- (void) setSelectedObject:(id<CellPresentable>)selectedObject
{
    _selectedObject = selectedObject;
}

- (bool) isVerified
{
    return _selectedObject;
}

- (id) value
{
    return _selectedObject;
}

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize delegate = _delegate;
@synthesize view = _view;

@synthesize setupTableViewCell = _setupTableViewCell;



@end
