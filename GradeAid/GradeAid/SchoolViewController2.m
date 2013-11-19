//
//  SchoolViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolViewController2.h"
#import "ClassViewViewController.h"
#import "AppDelegate.h"
#import "SchoolClass.h"
#import "RegisterObjectViewController.h"

@interface SchoolViewController2 ()
{
    IBOutlet UITableView *classView;
}

@end

@implementation SchoolViewController2

static NSString *CellIdentifier = @"CellIdentifier";

#pragma mark - Constructor Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {}
    return self;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [classView registerClass: [UITableViewCell class] forCellReuseIdentifier: CellIdentifier];
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action:@selector(addButtonPressed)];
    [self.navigationItem setRightBarButtonItem: addButton];
    
}

- (void) setupFetchResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"SchoolClass"];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"school.schoolID = %@", _school.schoolID];
    request.predicate = predicate;
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                        managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void) addButtonPressed
{

}

#pragma mark - ObjectVerifyer Delegate Methods

- (void) objectVerifyer:(id)sender createdObject:(id)object
{
    [self.tableView reloadData];
}

- (void) objectVerifyerCanceled:(id)sender
{
    
}

#pragma - Table View Datasource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    SchoolClass * schoolClass = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    [cell.textLabel setText: schoolClass.name];
    return cell;
}


#pragma mark - Table View Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ClassViewViewController *cvvc = [[ClassViewViewController alloc] initWithNibName: @"ClassViewViewController" bundle:nil];
    
    [self.navigationController pushViewController: cvvc animated: YES];
}

#pragma mark - Setters and Getters

@synthesize school = _school;

@end
