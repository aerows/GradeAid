//
//  EnrollmentTableView.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-27.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "EnrollmentTableView.h"
#import "Enrollment+Create.h"

#import "AppDelegate.h"
#import "RoundCorners.h"

static NSString *const StudentCellIdentifier = @"StudentCellIdentifier";

@implementation EnrollmentTableView
{
    NSFetchedResultsController *_fetchedEnrollmentsController;
}


- (void) reloadData
{
    [self setupFetchResultsControllers];
    self.delegate = self;
    self.dataSource = self;
    [super reloadData];
    [_tableViewDelegate tableViewDidUpdate: self];
}

- (void) endUpdates
{
    [super endUpdates];
    [_tableViewDelegate tableViewDidUpdate: self];
}

- (void) setupFetchResultsControllers
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Enrollment"];
    request.predicate = [NSPredicate predicateWithFormat: @"course = %@", _course];
    [request setSortDescriptors: [Enrollment studentLastNameSortDescriptors]];
    
    _fetchedEnrollmentsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                           managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                             sectionNameKeyPath: nil
                                                                                      cacheName: nil];
    _fetchedEnrollmentsController.delegate = self;
    [_fetchedEnrollmentsController performFetch: nil];
}


- (CGFloat) height
{
    CGFloat height = 0.f;
    for (int i = 0; i < [self numberOfSectionsInTableView: self]; i++) {
        for (int j = 0; j < [self tableView: self numberOfRowsInSection: i]; j++) {
            height += [self tableView:self heightForRowAtIndexPath: [NSIndexPath indexPathForRow: j inSection:i]];
        }
    }
    return height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_fetchedEnrollmentsController.sections.count)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedEnrollmentsController sections] objectAtIndex: 0];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: StudentCellIdentifier forIndexPath:indexPath];
    [self configureCell: cell atIndexPath: indexPath];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: self willDisplayCell: cell forRowAtIndexPath: indexPath];
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath: indexPath animated: YES];
    
    if (!_inEditMode)
    {
        Enrollment *enrollment = [_fetchedEnrollmentsController objectAtIndexPath: indexPath];
        [[NSNotificationCenter defaultCenter] postNotificationName: EnrolllmentWasSelectedNotification object: enrollment];
    }
}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self insertSections:[NSIndexSet indexSetWithIndex: sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    switch(type) {

        case NSFetchedResultsChangeInsert:
            [self insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate:

            [self configureCell:[self cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
    Enrollment *enrollment = [_fetchedEnrollmentsController objectAtIndexPath: indexPath];
    
    [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@", enrollment.student.lastName, enrollment.student.firstName]];
    
    [cell.detailTextLabel setText: enrollment.student.schoolClass.fullSchoolClassName];
    
    if (_inEditMode)
    {
        if (enrollment.course)
        {
            [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
            //            [cell.detailTextLabel setText: @"Course"];
        }
        else
        {
            [cell setAccessoryType: UITableViewCellAccessoryNone];
            //            [cell.detailTextLabel setText: @"Open"];
        }
    }
    else
    {
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self endUpdates];
}

#pragma mark - Setters and Getters

@synthesize course = _course;
@synthesize tableViewDelegate = _tableViewDelegate;

// state
@synthesize inEditMode = _inEditMode;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    [self reloadData];
    
}

@end
