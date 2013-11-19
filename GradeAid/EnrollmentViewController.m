//
//  CourseViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "EnrollmentViewController.h"

#import "AppDelegate.h"
#import "AquirementCell.h"

static NSString *const CourseSegueIdentifier = @"CourseSegueIdentifier";


@interface EnrollmentViewController ()

@end

@implementation EnrollmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_enrollment && _course.enrollments.count)
    {
        _enrollment = [_course.orderedEnrollments objectAtIndex: 0];
    }
    
    [self setupFetchResultsControllers];
    [_tableView setDelegate: self];
    [_tableView setDataSource: self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Getters and Setters

@synthesize tableView = _tableView;
@synthesize courseAquirementFetchController = _fetchedResultsController;


- (void) setupFetchResultsControllers
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Aquirement"];
    request.predicate = [NSPredicate predicateWithFormat: @"enrollment = %@", _enrollment];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"aquirementDescription.sectionTitle" ascending: YES],
                                   [NSSortDescriptor sortDescriptorWithKey: @"aquirementDescription.aquirementDescriptionID" ascending: YES]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                    managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                      sectionNameKeyPath: @"aquirementDescription.sectionTitle"
                                                                               cacheName:nil];
    _fetchedResultsController.delegate = self;
    [_fetchedResultsController performFetch: nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [AquirementCell heightForCellWithAquirement: [_fetchedResultsController objectAtIndexPath: indexPath]];
    return 170;
}

#pragma mark - UITableView Datasource Methods

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AquirementCell *cell = [tableView dequeueReusableCellWithIdentifier: AquirementCellCellIdentifier];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    Aquirement *aquirement = [_fetchedResultsController objectAtIndexPath: indexPath];
    [cell setAquirement: aquirement];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    int count = [[_fetchedResultsController sections] count];
    
    int i = [[_fetchedResultsController sections] count];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: CourseSegueIdentifier])
    {
        CourseTableViewController *courseTableViewController = (CourseTableViewController*)segue.destinationViewController;
        [courseTableViewController setCourse: _course];
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
    AquirementCell *aquirementCell = (AquirementCell*) cell;
    [aquirementCell setAquirement: nil];
    [aquirementCell setAquirement: [_fetchedResultsController objectAtIndexPath: indexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Getters and Setters

@synthesize course = _course;
@synthesize enrollment = _enrollment;

- (void) setEnrollment:(Enrollment *)enrollment
{
    if (_enrollment == enrollment) return;
    _enrollment = enrollment;
    [self setupFetchResultsControllers];
}

@end

