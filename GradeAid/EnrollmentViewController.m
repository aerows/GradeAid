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

#import "AquirementCell.h"
#import "ExpandableHeaderCell.h"

#import "AquirementListViewController.h"
#import "TeacherAquirementViewController.h"
#import "NotesViewController.h"

// Global
#import "AppDelegate.h"
#import "UIStoryboard+mainStoryboard.h"
#import "RoundCorners.h"

static NSString *const CourseSegueIdentifier = @"CourseSegueIdentifier";

static NSInteger const CourseAquirementHeaderSection = 0;
static NSInteger const CourseAquirementsSectionOffset = 1;

static CGRect SubViewControllerFrame = {0, 91, 768, 933};

@interface EnrollmentViewController ()

@property (nonatomic, strong) Student *student;

@end

@implementation EnrollmentViewController
{
    UIPopoverController *_currentPopoverController;
    
    bool _courseAquirementsVisable;
    
    AquirementListViewController *_aquirementListViewController;
    TeacherAquirementViewController *_teacherAquirementViewController;
    NotesViewController *_notesViewController;
}

- (void)viewDidLoad
{
    
    if (!_enrollment && _course.enrollments.count)
    {
        [self setEnrollment: [_course.orderedEnrollments objectAtIndex: 0]];
    }
    
    _aquirementListViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"AquirementListViewController"];
    _aquirementListViewController.enrollment = _enrollment;
    
    _teacherAquirementViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"TeacherAquirementViewController"];
    _teacherAquirementViewController.enrollment = _enrollment;
    
    _notesViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"NotesViewController"];
    
//    _aquirementListViewController.view.frame = SubViewControllerFrame;
//    [self.view addSubview: _aquirementListViewController.view];
//    [_aquirementListViewController didMoveToParentViewController: self];

    [self setViewControllers: @[_aquirementListViewController, _teacherAquirementViewController, _notesViewController]];
    [super viewDidLoad];

    
//    NSLog(@"Aquirements: %d",_enrollment.aquirements.count);
//    
//    // update
//    
//    [self setupFetchResultsControllers];
//    
//    [_tableView setDelegate: self];
//    [_tableView setDataSource: self];
}

- (CGRect) subviewControllerFrame
{
    return CGRectMake(0, 139, 768, 885);
}

- (void) willPresentViewControllerWithIndex:(NSInteger)index
{
    [[self.viewControllers objectAtIndex: index] setEnrollment: _enrollment];
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

- (IBAction) done:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: WillDismissViewControllerNotifification object: self];
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
        [cell.textLabel setText: @"Kunskapskrav"];
        [cell.detailTextLabel setText: @""];//[NSString stringWithFormat: @"%@", _course.name]];
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


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: _tableView willDisplayCell: cell forRowAtIndexPath: indexPath];
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

#pragma mark - View Display Methods

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self reloadViews];
}

#pragma mark - Helper Methods

- (void) reloadViews
{
    [_courseNameLabel setText: _course.name];
    [_studentNameLabel setText: _enrollment.student.fullName];
    [_studentSchoolClassLabel setText: _enrollment.student.schoolClass.fullSchoolClassName];
    
    NSInteger currentIndex = [_course.orderedEnrollments indexOfObject: _enrollment];
    if (currentIndex - 1 >= 0)
    {
        Student *previousStudent = [[_course.orderedEnrollments objectAtIndex: currentIndex - 1] student];
        [_previousStudentButton setTitle: previousStudent.fullName forState: UIControlStateNormal];
        [_previousStudentButton setEnabled: YES];
    }
    else
    {
        [_previousStudentButton setTitle: @"" forState: UIControlStateNormal];
        [_previousStudentButton setEnabled: NO];
    }
    
    if (currentIndex + 1 < _course.enrollments.count)
    {
        Student *nextStudent = [[_course.orderedEnrollments objectAtIndex: currentIndex + 1] student];
        [_nextStudentButton setTitle: nextStudent.fullName forState: UIControlStateNormal];
        [_nextStudentButton setEnabled: YES];
    }
    else
    {
        [_nextStudentButton setTitle: @"" forState: UIControlStateNormal];
        [_nextStudentButton setEnabled: NO];
    }
}

- (IBAction) nextStudent: (UIButton*) sender
{
    NSInteger currentIndex = [_course.orderedEnrollments indexOfObject: _enrollment];
    [self setEnrollment: [_course.orderedEnrollments objectAtIndex: currentIndex + 1]];
}

- (IBAction) previousStudent:(UIButton*) sender
{
    NSInteger currentIndex = [_course.orderedEnrollments indexOfObject: _enrollment];
    [self setEnrollment: [_course.orderedEnrollments objectAtIndex: currentIndex - 1]];
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
    
    _enrollment = enrollment;
    [self setupFetchResultsControllers];
    [_tableView reloadData];
    [self reloadViews];
    [_aquirementListViewController setEnrollment: _enrollment];
    [_teacherAquirementViewController setEnrollment: _enrollment];
}


@end

