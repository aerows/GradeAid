//
//  TeacherAquirementViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-06.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "TeacherAquirementViewController.h"

// View
#import "TeacherAquirementCell.h"

// Global
#import "AppDelegate.h"
#import "RoundCorners.h"

@interface TeacherAquirementViewController ()

@end

@implementation TeacherAquirementViewController
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
}

- (void) reloadData
{
    [self setupFetchResultsControllers];
    [_teacherAquirementTableView reloadData];
}

- (void) setupFetchResultsControllers
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"TeacherAquirement"];
    request.predicate = [NSPredicate predicateWithFormat: @"enrollment = %@", _enrollment];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"teacherAquirementDescription.caption" ascending: YES]]];
    
    _fetchedAquirementController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                       managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                         sectionNameKeyPath:nil
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherAquirement *aquirement = [_fetchedAquirementController objectAtIndexPath: indexPath];
    
    TeacherAquirementCell *cell = [tableView dequeueReusableCellWithIdentifier: TeacherAquirementCellIdentifier forIndexPath:indexPath];
    [cell setTeacherAquirement: aquirement];
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
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
    [_teacherAquirementTableView beginUpdates];
}




- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_teacherAquirementTableView insertSections:[NSIndexSet indexSetWithIndex: sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_teacherAquirementTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [_teacherAquirementTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_teacherAquirementTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[_teacherAquirementTableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [_teacherAquirementTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                        withRowAnimation:UITableViewRowAnimationFade];
            [_teacherAquirementTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
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
    [_teacherAquirementTableView endUpdates];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [_enrollment updateEnrollmentInManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
}

#pragma mark - Setters and Getters

- (void) setEnrollment:(Enrollment *)enrollment
{
    _enrollment = enrollment;
    [self reloadData];
}

@synthesize inEditMode = _inEditMode;
@synthesize enrollment = _enrollment;
@synthesize teacherAquirementTableView = _teacherAquirementTableView;
@synthesize noAquirementDescriptionsLabel = _noAquirementDescriptionsLabel;


@end
