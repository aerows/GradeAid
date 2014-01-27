//
//  SchoolClassTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClassTableViewController.h"
#import "StudentTableViewController.h"
#import "Student+Create.h"

static NSString *const CellIdentifier = @"SubtitleCell";
static NSString *const StudentTableSegueIdentifier = @"StudentTableSegueIdentifier";


@interface SchoolClassTableViewController ()

@end

@implementation SchoolClassTableViewController
{
    SchoolClass *_selectedSchoolClass;
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
    return _schoolClasses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SchoolClass *schoolClass = [_schoolClasses objectAtIndex: indexPath.row];
    
    [cell.textLabel setText: schoolClass.title];
    [cell.detailTextLabel setText: [NSString stringWithFormat: @"%d elever", schoolClass.students.count]];
    
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
    _selectedSchoolClass = [_schoolClasses objectAtIndex: indexPath.row];
    [self performSegueWithIdentifier: StudentTableSegueIdentifier sender: self];
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StudentTableViewController *stvc = (StudentTableViewController*) segue.destinationViewController;
    [stvc setCourse: _course];
    [stvc setStudents: [_selectedSchoolClass sortedStudents]];
}

#pragma mark - IBAction Methods

- (IBAction) done:(id)sender
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Setters and Getters

@synthesize schoolClasses = _schoolClasses;
@synthesize course = _course;

@end
