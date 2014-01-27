//
//  SchoolClassViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-11.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClassViewController.h"
#import "AppDelegate.h"

#import "AttributeInput.h"

#import "AttributeCell.h"
#import "PresentAttributeCell.h"

#import "StudentViewController.h"

#import "School+Create.h"
#import "Student+create.h"

static NSInteger const AttributeSection = 0;
static NSInteger const StudentSection = 1;

static NSString *const StudentCellIdentifier = @"StudentCellIdentifier";
static NSString *const StudentViewSegueIdentifier = @"StudentViewSegueIdentifier";

@interface SchoolClassViewController ()

@end

@implementation SchoolClassViewController
{
    AttributeInput *schoolClassYear;
    AttributeInput *schoolClassSuffix;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setInEditMode: !_schoolClass];
    
    schoolClassYear = [AttributeInput nameAttribute];
    schoolClassYear.attributeTitle = @"Årskull";
    schoolClassYear.attributeExample = @"År...";
    schoolClassYear.value = (!_schoolClass) ? @"" : [NSString stringWithFormat: @"%@", _schoolClass.year];
    
    schoolClassSuffix = [AttributeInput nameAttribute]; // Skall vara numberAttribute
    schoolClassSuffix.attributeTitle = @"Suffix";
    schoolClassSuffix.attributeExample = @"T.ex. A, b, \"natur\"...";
    schoolClassSuffix.value = (!_schoolClass) ? @"" : [NSString stringWithFormat: @"%@", _schoolClass.suffix];
    
    _attributes = @[schoolClassYear, schoolClassSuffix];
    
    [_tableView reloadData];
}

- (void) setupFetchResultsController
{

}

#pragma mark - IBAction Methods

- (IBAction) save: (id)sender
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    
    // Control input
    
    if (!_schoolClass)
    {
        _schoolClass = [SchoolClass schoolClassWithSchool: _selectedSchool year: @(schoolClassYear.value.intValue) suffix: schoolClassSuffix.value highschool: @(NO) managedObjectContext: moc];
        
        [_selectedSchool addClassesObject: _schoolClass];
    }
    else
    {
        _schoolClass.year = @(schoolClassYear.value.intValue);
        _schoolClass.suffix = schoolClassSuffix.value;
    }

    
    NSError *error = nil;
    [moc save: &error];
    if (error)
    {
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [self setInEditMode: NO];
}

- (IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - UITableView DataSource Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == AttributeSection)
    {
        return _attributes.count;
    }
    else
    {
        return _schoolClass.sortedStudents.count;
    }
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_schoolClass) ? 2 : 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == AttributeSection)
    {
        AttributeInput *attribute = [_attributes objectAtIndex: indexPath.row];
        
        if (_inEditMode)
        {
            AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];
            [cell setAttributeInput: attribute];
            return cell;
        }
        else
        {
            PresentAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: PresentAttributeCellIdentifier];
            [cell setAttributeInput: attribute];
            return cell;
        }
    }
    else if (indexPath.section == StudentSection)
    {
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier: StudentCellIdentifier];
        Student *student = [_schoolClass.sortedStudents objectAtIndex: indexPath.row];
        [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@", student.lastName, student.firstName]];
//        [cell.imageView setImage student];
        return cell;
    }
    return nil;
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: StudentViewSegueIdentifier])
    {
        StudentViewController *svc = (StudentViewController*) segue.destinationViewController;
        [svc setSelectedSchoolClass: _schoolClass];
    }
}

#pragma mark - Getters and Setters

@synthesize selectedSchool = _selectedSchool;
@synthesize schoolClass = _schoolClass;
@synthesize inEditMode = _inEditMode;
@synthesize attributes = _attributes;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    if (!_inEditMode)
    {
        [_titleLabel setText: _schoolClass.title];
    }
    else
    {
        if (_schoolClass)
        {
            [_titleLabel setText: [NSString stringWithFormat: @"Ändra klass: %@", _schoolClass.title]];
        }
        else
        {
            [_titleLabel setText: @"Skapa ny klass"];
        }
    }
    [_tableView reloadData];
}

@end

