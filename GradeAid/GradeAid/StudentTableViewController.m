//
//  StudentTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "AppDelegate.h"

#import "StudentTableViewController.h"
#import "Enrollment+Create.h"

#import "UIAlertView+MKBlockAdditions.h"

static NSString *const CellIdentifier = @"SubtitleCell";
static NSString *const SelectManyCellIdentifier = @"SelectManyCellIdentifier";

@interface StudentTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *oldCourses;

@property (nonatomic, strong) NSArray *openEnrollments;
@property (nonatomic, strong) NSArray *closedEnrollments;

@end

static NSInteger const AddClassSection = 0;
static NSInteger const AddUnEnrolledStudentSection = 1;
static NSInteger const OpenEnrollmentSection = 2;
static NSInteger const ClosedEnrollmentSection = 3;

@implementation StudentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case AddClassSection:               return 1;
        case AddUnEnrolledStudentSection:   return (_closedEnrollments.count) ? 1 : 0;
        case OpenEnrollmentSection:         return _openEnrollments.count;
        case ClosedEnrollmentSection:       return _closedEnrollments.count;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == AddClassSection)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SelectManyCellIdentifier];
        [cell.textLabel setText: @"Lägg till hela klassen"];
        return cell;
    }
    else if (indexPath.section == AddUnEnrolledStudentSection)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SelectManyCellIdentifier];
        [cell.textLabel setText: @"Lägg till alla lediga"];
        return cell;
    }
    else if (indexPath.section == OpenEnrollmentSection)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        Enrollment *enrollment = [_openEnrollments objectAtIndex: indexPath.row];
        [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@", enrollment.student.lastName, enrollment.student.firstName]];
        
        if (enrollment.course)
        {
            [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
            [cell.detailTextLabel setText: @"Course"];
        }
        else
        {
            [cell setAccessoryType: UITableViewCellAccessoryNone];
            [cell.detailTextLabel setText: @"Open"];
        }
        
        return cell;
    }
    else if (indexPath.section == ClosedEnrollmentSection)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        Enrollment *enrollment = [_closedEnrollments objectAtIndex: indexPath.row];
        [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@", enrollment.student.lastName, enrollment.student.firstName]];
        [cell.detailTextLabel setText: @"Closed"];
        return cell;
    }
    return nil;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    if (indexPath.section == AddClassSection)
    {
        UIAlertView *alert = [UIAlertView alertViewWithTitle: @"Lägg till alla" message: @"Vill du lägga till alla elever?" cancelButtonTitle: @"Nej" otherButtonTitles: @[@"Ja"] onDismiss:^(int buttonIndex)
        {
            [self addEnrollmentsToCourse: [_openEnrollments arrayByAddingObjectsFromArray: _closedEnrollments]];
            [tableView reloadData];
        } onCancel: nil];
        [alert show];
    }
    else if (indexPath.section == AddUnEnrolledStudentSection)
    {
        UIAlertView *alert = [UIAlertView alertViewWithTitle: @"Lägg till alla" message: @"Vill du lägga till alla lediga elever?" cancelButtonTitle: @"Nej" otherButtonTitles: @[@"Ja"] onDismiss:^(int buttonIndex)
                              {
                                  [self addEnrollmentsToCourse: _closedEnrollments];
                                  [tableView reloadData];
                              } onCancel: nil];
        [alert show];
    }
    else if (indexPath.section == OpenEnrollmentSection)
    {
        NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
        Enrollment *enrollment = [_openEnrollments objectAtIndex: indexPath.row];
        if (enrollment.course)
        {
            [enrollment unEnrollCourseInManagedObjectContext: moc];
        }
        else
        {
            [enrollment enrollInCourse: _course managedObjectContext: moc];
        }
        NSError *error = nil;
        [moc save: &error];
        if (error)
        {
            
        }
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        
    }
    else if (indexPath.section == ClosedEnrollmentSection)
    {
        UIAlertView *alert = [UIAlertView alertViewWithTitle: @"Lägg till upptagen elev" message: @"Vill du lägga till elev från annan lektion?" cancelButtonTitle: @"Nej" otherButtonTitles: @[@"Ja"] onDismiss:^(int buttonIndex)
                              {
                                  [self addEnrollmentsToCourse: @[[_closedEnrollments objectAtIndex:indexPath.row]]];
                                  [tableView reloadData];
                              } onCancel: nil];
        [alert show];
    }
}

- (void) addEnrollmentsToCourse: (NSArray*) enrollments
{
    NSManagedObjectContext *moc = AppDelegate.sharedDelegate.managedObjectContext;
    for (Enrollment *e in enrollments)
    {
        [e enrollInCourse: _course managedObjectContext: moc];
    }
    NSError *error = nil;
    [moc save: &error];
    if (error)
    {
        
    }
    [self setStudents: _students];
}


#pragma mark - IBAction Methods

- (IBAction) done:(id)sender
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Getters and Setters

- (void) setStudents: (NSArray *)students
{
    _students = students;
    
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    NSArray *enrollmentsForStudents = [Enrollment enrollmentsForStudents: students withCourseDescription:_course.courseEdition.courseDescription managedObjectContext: moc];

    NSPredicate *openPredicate = [NSPredicate predicateWithFormat: @"(course = %@ OR course = nil)", _course];
    NSPredicate *closedPredicate = [NSPredicate predicateWithFormat: @"(course != %@ AND course != nil)", _course];
    
    NSArray *openEnrollments = [enrollmentsForStudents filteredArrayUsingPredicate: openPredicate];
    NSArray *closedEnrollments = [enrollmentsForStudents filteredArrayUsingPredicate: closedPredicate];
    
    NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey: @"student.lastName" ascending: YES];
    NSSortDescriptor *sortByFirstName = [NSSortDescriptor sortDescriptorWithKey: @"student.firstName" ascending: YES];
    
    _openEnrollments = [openEnrollments sortedArrayUsingDescriptors: @[sortByLastName, sortByFirstName]];
    _closedEnrollments = [closedEnrollments sortedArrayUsingDescriptors: @[sortByLastName, sortByFirstName]];
}

@synthesize students = _students;
@synthesize course = _course;

@synthesize openEnrollments = _openEnrollments;
@synthesize closedEnrollments = _closedEnrollments;

@end
