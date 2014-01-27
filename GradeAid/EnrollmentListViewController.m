//
//  EnrollmentListViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "EnrollmentListViewController.h"
#import "SchoolTableViewController.h"

static NSString *const SelectStudentsIdentifier = @"SelectStudentsIdentifier";

@interface EnrollmentListViewController ()

@end

@implementation EnrollmentListViewController

#pragma mark - Constructor Methods

#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_enrollmentTableView setTableViewDelegate: self];
    [_enrollmentTableView setCourse: _course];
    [_enrollmentTableView reloadData];
    [self reloadView];
}

#pragma mark - IBAction Methods

- (IBAction) addStudentButtonPressed:(UIButton*)sender
{
    [self performSegueWithIdentifier: SelectStudentsIdentifier sender:self];
}

#pragma mark - TableView Delegate Methods

- (void) tableViewDidUpdate:(UITableView *)tableView
{
    
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: SelectStudentsIdentifier])
    {
        UINavigationController *nc = (UINavigationController*) segue.destinationViewController;
        SchoolTableViewController *stvc = (SchoolTableViewController*) [nc.viewControllers objectAtIndex: 0];
        [stvc setSchools: [School schoolsForCurrentTeacher]];
        [stvc setCourse: _course];
    }
}

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    [_enrollmentTableView setInEditMode: inEditMode];
    [self reloadView];
}

- (void) reloadView
{
    _addStudentsButton.alpha = (_inEditMode) ? 1.0f : 0.0f;
}

#pragma mark - Getters and Setters

// State
@synthesize inEditMode = _inEditMode;

// Model
@synthesize course              = _course;

// View
@synthesize enrollmentTableView = _enrollmentTableView;
@synthesize studensLabel        = _studentsLabel;
@synthesize addStudentsButton   = _addStudentsButton;
@synthesize noStudentsLabel     = _noStudentsLabel;

@end
