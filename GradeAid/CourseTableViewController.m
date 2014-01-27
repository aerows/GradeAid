//
//  CourseTableViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseTableViewController.h"

#import "Enrollment+Create.h"
#import "Student+Create.h"

static NSString *const CourseTableViewCellIdentifier = @"CourseTableViewCellIdentifier";

@interface CourseTableViewController ()

@end

@implementation CourseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_enrollments && _enrollments.count)
    {
        [_delegate setEnrollment: [_enrollments objectAtIndex: 0]];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _enrollments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CourseTableViewCellIdentifier forIndexPath:indexPath];
    
    Enrollment *enrollment = [_enrollments objectAtIndex: indexPath.row];
    Student *student = enrollment.student;
    [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@", student.lastName, student.firstName]];
    SchoolClass *class = student.schoolClass;
    [cell.detailTextLabel setText: [NSString stringWithFormat: @"%@ %@%@",
                                    class.school, class.year, class.suffix]];
    
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
    
    [_delegate setEnrollment: [_enrollments objectAtIndex: indexPath.row]];
}

#pragma mark - Getters and Setters

@synthesize delegate = _delegate;
@synthesize course = _course;
@synthesize enrollments = _enrollments;

- (void) setCourse:(Course *)course
{
    _course = course;
    _enrollments = course.orderedEnrollments;
    [self.tableView reloadData];
}



@end
