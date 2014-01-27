//
//  SchoolTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolTableViewController.h"
#import "SchoolClassTableViewController.h"

static NSString *const CellIdentifier = @"SubtitleCell";
static NSString *const SchoolClassTableSegueIdentifier = @"SchoolClassTableSegueIdentifier";

@interface SchoolTableViewController ()

@end

@implementation SchoolTableViewController
{
    School *_selectedSchool;
}

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
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _schools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    School *school = [_schools objectAtIndex: indexPath.row];
    
    [cell.textLabel setText: school.name];
    [cell.detailTextLabel setText: [NSString stringWithFormat: @"%d klasser", school.classes.count]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedSchool = [_schools objectAtIndex: indexPath.row];
    [self performSegueWithIdentifier: SchoolClassTableSegueIdentifier sender: self];
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SchoolClassTableViewController *sctvc = (SchoolClassTableViewController*) segue.destinationViewController;
    [sctvc setSchoolClasses: [SchoolClass schoolClassesForSchool: _selectedSchool]];
    [sctvc setCourse: _course];
}

#pragma mark - IBAction Methods

- (IBAction) done:(id)sender
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Setters and Getters

@synthesize schools = _schools;
@synthesize course = _course;

@end
