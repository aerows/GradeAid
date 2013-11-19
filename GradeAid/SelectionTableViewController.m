//
//  SelectionTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SelectionTableViewController.h"

@interface SelectionTableViewController ()

@end

@implementation SelectionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    if (!_selectedObjects)
    {
        _selectedObjects = [[NSMutableArray alloc] init];
    }
}

#pragma mark - IBAction Methods

- (IBAction) cancel :(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) done :(id)sender
{
    _onDone(_selectedObjects);
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SelectionTableViewControllerCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSManagedObject *object = (NSManagedObject*) [_objects objectAtIndex: indexPath.row];
    _setupCellWithObject(cell, object);
    
    bool selection = [self objectIsSelected: object];
    [self setSelection: selection forTableViewCell: cell];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    bool selected = [self objectIsSelected: [_objects objectAtIndex: indexPath.row]];
    
    selected ^= YES;
    
    [self setSelection: selected forObject: [_objects objectAtIndex: indexPath.row]];
    
    [tableView reloadData];
}

#pragma mark - Helper Methods

- (bool) objectIsSelected: (NSManagedObject*) object
{
    return [_selectedObjects containsObject: object];
}

- (void) setSelection: (bool) selected forObject: (NSManagedObject*) object
{
    if (selected == [self objectIsSelected: object]) return;
    if (selected)
    {
        if (_selectionStyle == SingleSelectionStyle)
        {
            [_selectedObjects removeAllObjects];
        }
        
        [_selectedObjects addObject: object];
    }
    else
    {
        [_selectedObjects removeObject: object];
    }
}

- (void) setSelection: (bool) selected forTableViewCell: (UITableViewCell*) cell
{
    if (selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@synthesize setupCellWithObject = _setupCellWithObject;
@synthesize onDone = _onDone;

@synthesize objects = _objects;
@synthesize selectedObjects = _selectedObjects;

@synthesize selectionStyle = _selectionStyle;

- (void) setSelectedObjects:(NSArray *)selectedObjects
{
    _selectedObjects = selectedObjects.mutableCopy;
}

@end
