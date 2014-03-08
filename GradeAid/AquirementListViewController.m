//
//  AquirementListViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "AquirementListViewController.h"

// View
#import "AquirementCell.h"

// Global
#import "AppDelegate.h"
#import "RoundCorners.h"

@interface AquirementListViewController ()

@end

@implementation AquirementListViewController
{
    NSFetchedResultsController *_fetchedAquirementController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadData];
    
    NSLog(@"%@", NSStringFromCGRect(_aquirementTableView.frame));
}

- (void) reloadData
{
    [self setupFetchResultsControllers];
    [_aquirementTableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self reloadData];
    [_aquirementTableView setFrame: self.view.bounds];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [_aquirementTableView setFrame: self.view.bounds];
}

- (void) setupFetchResultsControllers
{
    // aquirementDescription => courseDescription
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Aquirement"];
    
    request.predicate = [NSPredicate predicateWithFormat: @"(enrollment == %@) AND (aquirementDescription IN %@)", _enrollment, _enrollment.courseDescription.aquirementDescriptions];
    
//    request.predicate = [NSPredicate predicateWithFormat: @"enrollment = %@", _enrollment];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"aquirementDescription.sectionTitle" ascending: YES],
                                   [NSSortDescriptor sortDescriptorWithKey: @"aquirementDescription.aquirementDescriptionID" ascending: YES]]];
    
    _fetchedAquirementController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                    managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                      sectionNameKeyPath: @"aquirementDescription.sectionTitle"
                                                                               cacheName:nil];
    _fetchedAquirementController.delegate = self;
    [_fetchedAquirementController performFetch: nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _fetchedAquirementController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_fetchedAquirementController.sections.count)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedAquirementController sections] objectAtIndex: section];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [RoundCorners tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Aquirement *aquirement = [_fetchedAquirementController objectAtIndexPath: indexPath];
    
    AquirementCell *cell = [tableView dequeueReusableCellWithIdentifier: AquirementCellCellIdentifier forIndexPath:indexPath];
    [cell setAquirement: aquirement];
    [cell setEditmode: _inEditMode];
    [cell setEnableEdit: ^()
     {
         
     }];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Aquirement *aq = [_fetchedAquirementController objectAtIndexPath: indexPath];
    return [AquirementCell heightForCellWithAquirement: aq];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AquirementCell *aquirementCell = (AquirementCell*) cell;
    [RoundCorners tableView: _aquirementTableView willDisplayCell: cell forRowAtIndexPath: indexPath];
    [aquirementCell updateLayout];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if ([[_fetchedAquirementController sections] count])
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedAquirementController sections] objectAtIndex:section];
        return [sectionInfo name];
    }
    return nil;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath: indexPath animated: YES];
}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [_aquirementTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_aquirementTableView insertSections:[NSIndexSet indexSetWithIndex: sectionIndex]
                withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_aquirementTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [_aquirementTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_aquirementTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[_aquirementTableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [_aquirementTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
            [_aquirementTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
    //[cell setAquirement: [_fetchedAquirementController objectAtIndexPath: indexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_aquirementTableView endUpdates];
}

#pragma mark - Helper methods

- (void) updateEditModeForCells
{
    NSArray *indexPaths = [_aquirementTableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in indexPaths)
    {
        AquirementCell *cell = (AquirementCell*)[_aquirementTableView cellForRowAtIndexPath: indexPath];
        [cell setEditmode: _inEditMode];
    }
}

#pragma mark - Setters and Getters

- (void) setEnrollment:(Enrollment *)enrollment
{
    _enrollment = enrollment;
    [_enrollment updateEnrollmentInManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    [self reloadData];
}

@synthesize inEditMode = _inEditMode;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    [self updateEditModeForCells];
}

@synthesize enrollment = _enrollment;
@synthesize aquirementTableView = _aquirementTableView;
@synthesize noAquirementDescriptionsLabel = _noAquirementDescriptionsLabel;

@end
