//
//  CourseViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "EnrollmentViewController.h"

#import "Student+Create.h"
#import "School+Create.h"

#import "AppDelegate.h"
#import "AquirementCell.h"
#import "ExpandableHeaderCell.h"

static NSString *const CourseSegueIdentifier = @"CourseSegueIdentifier";

static NSInteger const CourseAquirementHeaderSection = 0;
static NSInteger const CourseAquirementsSectionOffset = 1;


@interface EnrollmentViewController ()

@property (nonatomic, strong) Student *student;

@end

@implementation EnrollmentViewController
{
    UIPopoverController *_currentPopoverController;
    
    bool _courseAquirementsVisable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_enrollment && _course.enrollments.count)
    {
        [self setEnrollment: [_course.orderedEnrollments objectAtIndex: 0]];
    }
    
    // update
    
    [self setupFetchResultsControllers];
    
    [_tableView setDelegate: self];
    [_tableView setDataSource: self];

}

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

#pragma mark - IBAction Methods

- (IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}


#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.section == CourseAquirementHeaderSection)
    {
        _courseAquirementsVisable ^= YES;
        [_tableView reloadData];
    }
}



#pragma mark - UITableView Datasource Methods

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == CourseAquirementHeaderSection)
    {
        ExpandableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier: ExpandableHeaderCellIdentifier];
        [cell.textLabel setText: @"Kurskriterier"];
        [cell.detailTextLabel setText: @"Detailed kurskriterier"];
        [cell.expandLabel setText: (_courseAquirementsVisable) ? @"Dölj" : @"Visa"];
        return cell;
    }
    else if (indexPath.section >= CourseAquirementsSectionOffset &&
             indexPath.section <= CourseAquirementsSectionOffset + _fetchedResultsController.sections.count)
    {
        NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row inSection: indexPath.section - CourseAquirementsSectionOffset];
        AquirementCell *cell = [tableView dequeueReusableCellWithIdentifier: AquirementCellCellIdentifier];
        [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
        Aquirement *aquirement = [_fetchedResultsController objectAtIndexPath: indexPathWithOffset];
        [cell setAquirement: aquirement];
        return cell;
    }

    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == CourseAquirementHeaderSection)
    {
        return 40.f;
    }
    else
    {
        NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row
                                                              inSection: indexPath.section - CourseAquirementsSectionOffset];
        Aquirement *aq = [_fetchedResultsController objectAtIndexPath: indexPathWithOffset];
        return [AquirementCell heightForCellWithAquirement: aq];
    }
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    int numberOfSection = 1; // CourseAquirementHeaderSection
    numberOfSection += (_courseAquirementsVisable) ? [[_fetchedResultsController sections] count] : 0;

    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (section == CourseAquirementHeaderSection)
    {
        return 1;
    }
    else if ([[_fetchedResultsController sections] count] > 0) {
        NSInteger sectionWithOffset = section - CourseAquirementsSectionOffset;
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:sectionWithOffset];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == CourseAquirementHeaderSection)
    {
        return nil;
    }
    else if ([[_fetchedResultsController sections] count] > 0) {
        NSInteger sectionWithOffset = section - CourseAquirementsSectionOffset;
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:sectionWithOffset];
        return [sectionInfo name];
    } else
        return nil;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return [_fetchedResultsController sectionIndexTitles];
//}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return [_fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
//}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    NSInteger sectionWithOffset = sectionIndex + CourseAquirementsSectionOffset;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionWithOffset]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionWithOffset]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row
                                                          inSection: indexPath.section + CourseAquirementsSectionOffset];
    NSIndexPath *newIndexPathWithOffset = [NSIndexPath indexPathForRow: newIndexPath.row
                                                          inSection: newIndexPath.section + CourseAquirementsSectionOffset];
    
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPathWithOffset]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathWithOffset]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[tableView cellForRowAtIndexPath:indexPathWithOffset]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathWithOffset]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPathWithOffset]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: CourseSegueIdentifier])
    {
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
        _currentPopoverController = popoverSegue.popoverController;
        
        CourseTableViewController *courseTableViewController = (CourseTableViewController*)segue.destinationViewController;
        [courseTableViewController setCourse: _course];
        [courseTableViewController setDelegate: self];
    }
}

- (void) configureCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath
{
//    NSIndexPath *indexPathWithOffset = [NSIndexPath indexPathForRow: indexPath.row inSection: indexPath.section - CourseAquirementsSectionOffset];
    AquirementCell *aquirementCell = (AquirementCell*) cell;
    [aquirementCell setAquirement: nil];
    [aquirementCell setAquirement: [_fetchedResultsController objectAtIndexPath: indexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Getters and Setters

@synthesize tableView = _tableView;
@synthesize courseAquirementFetchController = _fetchedResultsController;
@synthesize course = _course;
@synthesize enrollment = _enrollment;
@synthesize student = _student;

- (void) setEnrollment:(Enrollment *)enrollment
{
    [_currentPopoverController dismissPopoverAnimated: YES];
    _currentPopoverController = nil;
    
    //    if (_enrollment == enrollment) return;
    _enrollment = enrollment;
    [self setupFetchResultsControllers];
    [_tableView reloadData];
    [self setStudent: _enrollment.student];
}

- (void) setStudent:(Student *)student
{
    _student = student;
    
    [_studentImageView setImage: _student.studentImage];
    [_studentNameLabel setText: [NSString stringWithFormat: @"%@ %@", _student.firstName, _student.lastName]];
    [_studentSchoolClassLabel setText: _student.schoolClass.name];
    [_studentSchoolLabel setText: _student.schoolClass.school.name];
}

@end

