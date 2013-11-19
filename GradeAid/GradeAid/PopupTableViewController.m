//
//  PopupTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "PopupTableViewController.h"

@interface PopupTableViewController ()

@end

@implementation PopupTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PopupTableViewControllerCellIdentifier forIndexPath:indexPath];
    NSManagedObject *object = (NSManagedObject*) [_objects objectAtIndex: indexPath.row];
    _setupCellWithObject(cell, object);
    return cell;
}

#pragma mark - TableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = (NSManagedObject*)[_objects objectAtIndex: indexPath.row];
    _onSelectObject(object);
    if (_clearOnSelection)
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
    
}

#pragma mark - Getters and Setters

@synthesize objects = _objects;
@synthesize onSelectObject = _onSelectObject;
@synthesize setupCellWithObject = _setupCellWithObject;
@synthesize clearOnSelection = _clearOnSelection;

@end
