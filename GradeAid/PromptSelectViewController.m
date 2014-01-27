//
//  PromptSelectViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-12.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "PromptSelectViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "RoundCorners.h"

@interface PromptSelectViewController ()

@end

@implementation PromptSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) init
{
    self = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"PromptSelectViewController"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadObjects];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_displayPlusOption) ? _objects.count + 1 : _objects.count;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: _tableView willDisplayCell: cell forRowAtIndexPath: indexPath];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [RoundCorners tableView: tableView viewForHeaderInSection: section];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _objects.count)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CreateNewCellIdentifier forIndexPath: indexPath];
        [cell.textLabel setText: _plusOptionTitle];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ObjectCellIdentifier forIndexPath: indexPath];
        id object = [_objects objectAtIndex: indexPath.row];
        [cell.imageView setImage: [self imageForObject: object]];
        [cell.textLabel setText: [self titleForObject: object]];
        return cell;
    }
}

- (UIImage*) imageForObject:(id)object
{
    // To be subclassed
    return nil;
}

- (NSString*) titleForObject:(id)object
{
    // To be subclassed
    return @"";
}

- (void) reloadObjects
{
    // To be subclassed
}

- (void) createNewButtonPressed
{
    // To be subclassed
}

#pragma mark - UITableViewDelegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _objects.count)
    {
        [self createNewButtonPressed];
    }
    else
    {
        _object = [_objects objectAtIndex: indexPath.row];
        _doneSelectingBlock(self, _object);
    }
}

@synthesize object = _object;
@synthesize objects = _objects;

@synthesize plusOptionTitle = _plusOptionTitle;
@synthesize doneSelectingBlock = _doneSelectingBlock;
@synthesize displayPlusOption = _displayPlusOption;

@end
