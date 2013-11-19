//
//  SchoolViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolViewController.h"
#import "AppDelegate.h"

#import "AttributeInput.h"

#import "AttributeCell.h"
#import "PresentAttributeCell.h"



@interface SchoolViewController ()

@end

@implementation SchoolViewController
{
    AttributeInput *schoolNameAttribute;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setInEditMode: !_school];
    
    schoolNameAttribute = [AttributeInput nameAttribute];
    schoolNameAttribute.attributeTitle = @"Namn";
    schoolNameAttribute.attributeExample = @"Skolans namn...";
    schoolNameAttribute.value = _school.name;
    
    [_tableView reloadData];
}

#pragma mark - IBAction Methods

- (IBAction) save: (id)sender
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    
    // Control input
    
    if (!_school)
    {
        _school = [School schoolWithDict: @{} inManagedObjectContext: moc];
        [[Session currentSession].teacher addSchoolsObject: _school];
    }
    _school.name = schoolNameAttribute.value;
    
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
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_inEditMode)
    {
        AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];
        [cell setAttributeInput: schoolNameAttribute];
        return cell;
    }
    else
    {
        PresentAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier: AttributeCellIdentifier];
        [cell setAttributeInput: schoolNameAttribute];
        return cell;
    }
}

#pragma mark - Getters and Setters

@synthesize school = _school;
@synthesize inEditMode = _inEditMode;

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    if (!_inEditMode)
    {
        [_titleLabel setText: _school.name];
    }
    else
    {
        if (_school)
        {
            [_titleLabel setText: [NSString stringWithFormat: @"Ändra skola: %@", _school.name]];
        }
        else
        {
            [_titleLabel setText: @"Skapa ny skola"];
        }
    }
}

@end
