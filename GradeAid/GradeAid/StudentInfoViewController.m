//
//  StudentInfoViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-02-02.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "StudentInfoViewController.h"

// Model
#import "SchoolClass+Create.h"
#import "Enrollment+Create.h"
#import "Course+Create.h"

// View
#import "EnrollmentViewController.h"

// Global
#import "UIStoryboard+mainStoryboard.h"

@interface StudentInfoViewController ()

@end

static NSString *const InfoCellIdentifer = @"InfoCellIdentifer";
static NSString *const EnrollmentCellIdentifier = @"EnrollmentCellIdentifier";

static int const SectionInfo = 0;
static int const SectionClass = 1;
static int const SectionEnrollments = 2;

static int const RowFirstName = 0;
static int const RowLastName  = 1;
static int const RowEmail     = 2;

@implementation StudentInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.navigationController && self.navigationController.viewControllers.count == 1)
    {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Klar" style:UIBarButtonItemStylePlain target: self action: @selector(doneButtonPressed)];
        [self.navigationItem setLeftBarButtonItem: doneButton];
    }
    
}

- (void) doneButtonPressed
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _enrollments = [_student sortedEnrollments];
    [_imageView setImage: [_student studentImage]];
    [_tableView reloadData];
}

#pragma mark - UITableView Datasource Methods

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case SectionInfo:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: InfoCellIdentifer forIndexPath:indexPath];
            switch (indexPath.row)
            {
                case RowFirstName:
                {
                    cell.textLabel.text = @"Förnamn";
                    cell.detailTextLabel.text       = _student.firstName;
                    break;
                }
                case RowLastName:
                {
                    cell.textLabel.text = @"Efternamn";
                    cell.detailTextLabel.text       = _student.lastName;
                    break;
                }
                case RowEmail:
                {
                    cell.textLabel.text = @"Epost";
                    cell.detailTextLabel.text       = (_student.email) ? _student.email : @"Ingen epost"; break;
                }
            }
            return cell;
        }
        case SectionClass:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: InfoCellIdentifer forIndexPath:indexPath];
            cell.textLabel.text = @"Klass";
            cell.detailTextLabel.text       = _student.schoolClass.fullSchoolClassName;
            return cell;
        }
        case SectionEnrollments:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: InfoCellIdentifer forIndexPath:indexPath];
            Enrollment *enrollment = [_enrollments objectAtIndex: indexPath.row];
            cell.detailTextLabel.text = enrollment.course.fullNameDescription;
            cell.textLabel.text = @"";
            [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
            return cell;
        }
    }
    NSLog(@"Reached end of UITableViewCell method.");
    return nil;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case SectionInfo:        return 3;
        case SectionClass:       return 1;
        case SectionEnrollments: return _enrollments.count;
        default: return 0;
    }
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    if (indexPath.section == SectionEnrollments)
    {
        EnrollmentViewController *enrollmentViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"EnrollmentViewController"];
        enrollmentViewController.enrollment = [_enrollments objectAtIndex: indexPath.row];
        [self.navigationController pushViewController: enrollmentViewController animated: YES];
    }
}

#pragma mark - Getters and Setters

- (void) setStudent:(Student *)student
{
    _student = student;
    _imageView.image = _student.studentImage;
    _enrollments = _student.sortedEnrollments;
}

@synthesize student = _student;
@synthesize enrollments = _enrollments;

@end
