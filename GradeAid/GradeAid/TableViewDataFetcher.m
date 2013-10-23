//
//  TableViewDataFetcher.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-17.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "TableViewDataFetcher.h"

@implementation TableViewDataFetcher

#pragma mark - Constructor Methods

- (id) initWithFetchController:(NSFetchedResultsController *)fetchedResultsController tableView:(UITableView *)tableView delegate:(id<TableViewDataFetcherDelegate>)delegate
{
    if (self = [super init])
    {
        [self setFetchedResultsController: fetchedResultsController];
        [self setTableView: tableView];
        [self setDelegate: delegate];
    }
    return self;
}

#pragma mark - UITableView Datasource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [_fetchedResultsController objectAtIndexPath: indexPath];
    return [_delegate tableView: _tableView cellWithObject: object atIndexPath: indexPath];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [_fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void) update
{
    if (_delegate && _tableView && _fetchedResultsController)
    {
        [_fetchedResultsController performFetch: nil];
    }
}

#pragma mark - Getters and Setters

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (void) setDelegate:(id<TableViewDataFetcherDelegate>)delegate
{
    if ([_delegate isEqual: delegate]) return;
    _delegate = delegate;
    [self update];
}

- (void) setTableView:(UITableView *)tableView
{
    if ([_tableView isEqual: tableView]) return;
    _tableView = tableView;
    [_tableView setDataSource: self];
    [self update];
}

- (void) setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    if ([_fetchedResultsController isEqual: fetchedResultsController]) return;
    _fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
    [self update];
}

@end
