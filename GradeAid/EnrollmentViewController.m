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
#import "TeacherAquirementCell.h"
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self setIsEditing: _isEditing];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self reloadViews];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(enableEdit:) name:AquirementCellDidEnableEditNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(enableEdit:) name: TeacherAquirementCellDidEnableEditNotification object: nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) enableEdit: (NSNotification*) notification
{
    [self setIsEditing: YES];
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
        [_previousStudentButton setTitle: [NSString stringWithFormat: @"< %@", previousStudent.fullName] forState: UIControlStateNormal];
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
        [_nextStudentButton setTitle: [NSString stringWithFormat: @"%@ >", nextStudent.fullName] forState: UIControlStateNormal];
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

#pragma mark - IBAction Methods

- (IBAction) editButtonPressed: (UIButton*) button
{
    // save
    [self setIsEditing: !_isEditing];
}

- (IBAction) cancelEditButtonPressed: (UIButton*) button
{
#warning todo
    // cancel
    [self setIsEditing: NO];
}

#pragma mark - Getters and Setters

@synthesize tableView = _tableView;
@synthesize courseAquirementFetchController = _fetchedResultsController;
@synthesize course = _course;
@synthesize enrollment = _enrollment;
@synthesize student = _student;
@synthesize isEditing = _isEditing;

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

- (void) setIsEditing:(bool)isEditing
{
    _isEditing = isEditing;
    
    [_editButton setTitle: (isEditing) ? @"Klar": @"Ändra" forState: UIControlStateNormal];
    [_cancelEditingButton setAlpha: (isEditing) ? 1.0 : 0.0];
    [_penButton setTintColor: (isEditing) ? colorTintedBlue : [UIColor clearColor]];
    
    [_nextStudentButton setEnabled: !isEditing];
    [_previousStudentButton setEnabled: !isEditing];
    
    [_segmentedControl setEnabled: !isEditing];
    [_doneButton setEnabled: !isEditing];
    [_popdownStudentButton setEnabled: !isEditing];
    
    [_aquirementListViewController setInEditMode: _isEditing];
    [_teacherAquirementViewController setInEditMode: _isEditing];
}

@end

