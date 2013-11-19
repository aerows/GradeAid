//
//  RegisterStudentViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "RegisterStudentViewController.h"
#import "School+Create.h"
#import "SchoolClass+Create.h"
#import "SellectionViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "AttributeCell.h"
#import "SellectionCell.h"
#import "AppDelegate.h"
#import "PresentAttributeCell.h"

static NSInteger const AttributeInputSection  = 0;
static NSInteger const AttributeSelectSection = 1;

@interface RegisterStudentViewController ()
{
    AttributeInput *studentFirstName;
    AttributeInput *studentLastName;
    AttributeInput *studentEmail;
    SellectionVerifyer *schoolSelection;
    SellectionVerifyer *schoolClassSelection;
}

@end

@implementation RegisterStudentViewController

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
    
    schoolSelection = [[SellectionVerifyer alloc] initWithArray: [School schoolsForCurrentTeacher]];
    [schoolSelection setSelectedObject: _selectedSchool];
    schoolSelection.delegate = self;
    
    NSArray *schoolClasses;
    if (schoolSelection.selectedObject)
    {
        schoolClasses = [SchoolClass schoolClassesForSchool: (School*)schoolSelection.selectedObject];
    }
    else
    {
        schoolClasses = [SchoolClass schoolClassesForCurrentTeacher];
    }
    
    schoolClassSelection = [[SellectionVerifyer alloc] initWithArray: schoolClasses];
    [schoolClassSelection setSelectedObject: _selectedSchoolClass];
    schoolClassSelection.delegate = self;

    _attributeInputs = @[studentFirstName, studentLastName, studentEmail];
    _attributeSelectors = @[schoolSelection, schoolClassSelection];
    
    _studentTableView.delegate = self;
    _studentTableView.dataSource = self;
}

- (void) save
{
    self.managedObjectContext = [AppDelegate sharedDelegate].managedObjectContext;
    
    if (!_student)
    {
        _student = [Student studentWithDict: @{} inManagedObjectContext: self.managedObjectContext];
    }
    _student.firstName = studentFirstName.value;
    _student.lastName  = studentLastName.value;
    _student.email = studentEmail.value;
        
    _student.schoolClass = schoolClassSelection.value;

    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma - Button Methods

- (IBAction) saveButtonPressed: (id) sender
{
    [self save];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) plusButtonPressed: (id) sender
{
    [self save];
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
        case AttributeSelectSection:
        {
            SellectionCell *cell = [tableView dequeueReusableCellWithIdentifier: SellectionCellIdentifier];
            [cell setSellectionVerifyer: [_attributeSelectors objectAtIndex: indexPath.row]];
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
        case AttributeSelectSection: return _attributeSelectors.count;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case AttributeInputSection:  return 55.f;
        case AttributeSelectSection: return 43.f;
    }
    return 0;
}


#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_inEditMode) return;
    
    if (indexPath.section == AttributeSelectSection)
    {
        SellectionVerifyer *sellectionVerifyer = [_attributeSelectors objectAtIndex: indexPath.row];
        
        SellectionViewController *svc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"SellectionViewController"];
        
        CGSize svcSize = [svc sizeForNumberOfObjects: sellectionVerifyer.objects.count];
        svc.view.frame = (CGRect){CGPointZero, svcSize};
        
        [svc setSellectionVerifyer: sellectionVerifyer];
        
        CGRect frame = CGRectOffset([tableView rectForRowAtIndexPath: indexPath], tableView.frame.origin.x, tableView.frame.origin.y);
        
        _currentPopoverController = [[UIPopoverController alloc] initWithContentViewController:svc];
        _currentPopoverController.delegate = self;
        _currentPopoverController.popoverContentSize = svcSize;
        [_currentPopoverController presentPopoverFromRect: frame inView:self.view permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - SelectionVerifyer Delegate Methods

- (void) updateSellectionVerifyerDelegate
{
    if (![_selectedSchool isEqual: schoolSelection.selectedObject])
    {
        _selectedSchool = (School*)schoolSelection.selectedObject;
        [schoolClassSelection setObjects: [SchoolClass schoolClassesForSchool: _selectedSchool]];
    }
    
    [_studentTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateSchoolClasses
{
    
}

#pragma mark - Helper Methods

#pragma mark - Getters and Setters

@synthesize studentTableView = _studentTableView;

@synthesize student = _student;

@synthesize inEditMode = _inEditMode;

@synthesize attributeInputs = _attributeInputs;
@synthesize attributeSelectors = _attributeSelectors;

@synthesize selectedSchool = _selectedSchool;
@synthesize selectedSchoolClass = _selectedSchoolClass;

@end
