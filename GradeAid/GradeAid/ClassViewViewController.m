//
//  ClassViewViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-19.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "ClassViewViewController.h"
#import "Student.h"
#import "AppDelegate.h"

@interface ClassViewViewController ()
{
    IBOutlet UITableView *studentView;
}

@end

@implementation ClassViewViewController

@synthesize students = _students;

static NSString *CellIdentifier = @"CellIdentifier2";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [studentView registerClass: [UITableViewCell class] forCellReuseIdentifier: CellIdentifier];
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
}

- (void) setupFetchResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"SchoolClass"];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                        managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

#pragma - Table View Datasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _students.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    NSString *string = [_students objectAtIndex: indexPath.item];
    [cell.textLabel setText: string];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected: %@", [_students objectAtIndex: indexPath.item]);
}

@end
