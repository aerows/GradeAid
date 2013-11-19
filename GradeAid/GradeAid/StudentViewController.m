//
//  StudentViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "StudentViewController.h"
#import "School+Create.h"
#import "SchoolClass+Create.h"
#import "UIStoryboard+mainStoryboard.h"
#import "AttributeCell.h"
#import "AppDelegate.h"
#import "PresentAttributeCell.h"
#import "SelectionTableViewController.h"


static NSInteger const AttributeInputSection  = 0;
static NSInteger const SchoolClassSection = 1;

static NSString *const SelectClassSegueIdentifier = @"SelectClassSegueIdentifier";
static NSString *const SchoolClassCellIdentifier  = @"SchoolClassCellIdentifier";

@interface StudentViewController ()
{
    AttributeInput *studentFirstName;
    AttributeInput *studentLastName;
    AttributeInput *studentEmail;
}

@end

@implementation StudentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_student) _inEditMode = YES;
    
    studentFirstName = [AttributeInput nameAttribute];
    studentFirstName.attributeTitle = @"Förnamn";
    studentFirstName.attributeExample = @"Förnamn...";
    studentFirstName.value = _student.firstName;
    
    studentLastName = [AttributeInput nameAttribute];
    studentLastName.attributeTitle = @"Efternamn";
    studentLastName.attributeExample = @"Efternamn...";
    studentLastName.value = _student.lastName;
    
    studentEmail = [AttributeInput nameAttribute]; // Skall vara epostAttribute
    studentEmail.attributeTitle = @"Epost";
    studentEmail.attributeExample = @"namn@mail.se...";
    studentEmail.value = _student.email;

    
    _attributeInputs = @[studentFirstName, studentLastName, studentEmail];
    
    _studentTableView.delegate = self;
    _studentTableView.dataSource = self;
}

- (void) save
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    
    if (!_student)
    {
        _student = [Student studentWithDict: @{} inManagedObjectContext: moc];
    }
    _student.firstName = studentFirstName.value;
    _student.lastName  = studentLastName.value;
    _student.email = studentEmail.value;
    
    _student.schoolClass = _selectedSchoolClass;
    
    NSError *error = nil;
    if (![moc save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self setInEditMode: NO];
}

#pragma - Button Methods

- (IBAction) saveButtonPressed: (id) sender
{
    [self save];
}

- (IBAction) plusButtonPressed: (id) sender
{
    [self save];
}

- (IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}
#pragma mark - UITableView Datasource Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case AttributeInputSection:
        {
            if (_inEditMode)
            {
                AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];
                [cell setAttributeInput: [_attributeInputs objectAtIndex: indexPath.row]];
                return cell;
            }
            else
            {
                PresentAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: PresentAttributeCellIdentifier];
                [cell setAttributeInput: [_attributeInputs objectAtIndex: indexPath.row]];
                return cell;
            }
        }
        case SchoolClassSection:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SchoolClassCellIdentifier];
            if (!_selectedSchoolClass)
            {
                [cell.textLabel setText: @"Ingen klass vald"];
                [cell.detailTextLabel setText: @"Klicka för att välja klass"];
            }
            else
            {
                [cell.textLabel setText: _selectedSchoolClass.name];
                [cell.detailTextLabel setText: @""];
            }
            return cell;
        }
    }
    NSLog(@"IndexPath section out of range.");
    return nil;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case AttributeInputSection:  return _attributeInputs.count;
        case SchoolClassSection:     return 1;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case AttributeInputSection:  return 55.f;
        case SchoolClassSection: return 40.f;
    }
    return 0;
}


#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_inEditMode) return;
    
    if (indexPath.section == SchoolClassSection)
    {
        [self performSegueWithIdentifier: SelectClassSegueIdentifier sender: self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: SelectClassSegueIdentifier])
    {
        SelectionTableViewController *stvc = segue.destinationViewController;
        [stvc setSelectionStyle: SingleSelectionStyle];
        [stvc setObjects: [SchoolClass schoolClassesForCurrentTeacher]];
        if (_selectedSchoolClass)
        {
            [stvc setSelectedObjects: @[_selectedSchoolClass]];
        }
        [stvc setSetupCellWithObject:^(UITableViewCell *cell, NSManagedObject *object) {
            SchoolClass *schoolClass = (SchoolClass*) object;
            [cell.textLabel setText: schoolClass.name];
            [cell.detailTextLabel setText: schoolClass.school.name];
        }];
        [stvc setOnDone:^(NSArray *selectedObjects) {
            _selectedSchoolClass = [selectedObjects lastObject];
            [self.studentTableView beginUpdates];
            [self.studentTableView reloadSections: [NSIndexSet indexSetWithIndex: SchoolClassSection] withRowAnimation: UITableViewRowAnimationAutomatic];
            [self.studentTableView endUpdates];
        }];
    }
}

#pragma mark - Helper Methods

#pragma mark - Getters and Setters

@synthesize studentTableView = _studentTableView;
@synthesize inEditMode = _inEditMode;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    if (!_inEditMode)
    {
        [_titleLabel setText: _student.title];
    }
    else
    {
        if (_student)
        {
            [_titleLabel setText: [NSString stringWithFormat: @"Ändra klass: %@", _student.title]];
        }
        else
        {
            [_titleLabel setText: @"Skapa ny elev"];
        }
    }
    [_studentTableView reloadData];
}

@synthesize student = _student;

@synthesize attributeInputs = _attributeInputs;
@synthesize selectedSchoolClass = _selectedSchoolClass;

@end
