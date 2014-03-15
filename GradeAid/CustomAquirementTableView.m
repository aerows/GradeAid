//
//  CustomAquirementTableView.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CustomAquirementTableView.h"
#import "AquirementDescription+Create.h"
#import "AppDelegate.h"
#import "TeacherAquirementDescriptionEditCell.h"
#import "RoundCorners.h"

static NSString *const TeacherAquirementCellIdentifier = @"TeacherAquirementCellIdentifier";

@implementation CustomAquirementTableView

{
    NSFetchedResultsController *_fetchedAquirementDescriptionController;
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"TeacherAquirementDescription"];
    request.predicate = [NSPredicate predicateWithFormat: @"SELF IN %@", _course.courseEdition.teacherAquirementDescriptions];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"caption" ascending: YES]]];
    
    _fetchedAquirementDescriptionController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                        managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                          sectionNameKeyPath: nil
                                                                                   cacheName: nil];
    _fetchedAquirementDescriptionController.delegate = self;
    [_fetchedAquirementDescriptionController performFetch: nil];
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

- (void) selectForEditing:(TeacherAquirementDescription *)teacherAquirementDescription
{
    if (!_inEditMode) return;
    NSIndexPath *indexPathForEditing = [_fetchedAquirementDescriptionController indexPathForObject: teacherAquirementDescription];
    TeacherAquirementDescriptionEditCell *cell = (TeacherAquirementDescriptionEditCell*) [self cellForRowAtIndexPath: indexPathForEditing];
    [cell.textField becomeFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [RoundCorners tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_fetchedAquirementDescriptionController.sections.count)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedAquirementDescriptionController sections] objectAtIndex: 0];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block TeacherAquirementDescription *aqDesc = [_fetchedAquirementDescriptionController objectAtIndexPath: indexPath];
    
    if (_inEditMode)
    {
        TeacherAquirementDescriptionEditCell *cell = [tableView dequeueReusableCellWithIdentifier: TeacherAquirementEditCellIdentifier forIndexPath:indexPath];
        [cell setTeacherAquirementDescription: aqDesc];
        cell.deleteAquirementBlock = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [TeacherAquirementDescription deleteTeacherAquirement: aqDesc];
            });
        };
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TeacherAquirementCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setText: aqDesc.caption];
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: self willDisplayCell: cell forRowAtIndexPath:indexPath];
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath: indexPath animated: YES];
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
//    AquirementDescription *aqDesc = [_fetchedAquirementDescriptionController objectAtIndexPath: indexPath];
//    
//    [cell.textLabel setText: [NSString stringWithFormat: @"%@", aqDesc]];
    
//    if (enrollment.course)
//    {
//        [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
//        [cell.detailTextLabel setText: @"Course"];
//    }
//    else
//    {
//        [cell setAccessoryType: UITableViewCellAccessoryNone];
//        [cell.detailTextLabel setText: @"Open"];
//    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self endUpdates];
}

#pragma mark - Setters and Getters
// State
@synthesize inEditMode = _inEditMode;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    [self reloadData];
}

// Model
@synthesize course = _course;

// View
@synthesize tableViewDelegate = _tableViewDelegate;

@end
