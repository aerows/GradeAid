//
//  SubjectViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-21.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SubjectViewController.h"
#import "CourseDescription+Create.h"
#import "CourseEdition+Create.h"
#import "Subject+Create.h"

static NSString *const SelectStudentsIdentifier = @"SelectStudentsIdentifier";

@interface SubjectViewController ()

@end

@implementation SubjectViewController

#pragma mark - Constructor Methods

#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_subjectTableView setTableViewDelegate: self];
    [_subjectTableView setSubject: _course.courseEdition.courseDescription.subject];
    [_subjectTableView reloadData];
}

#pragma mark - TableView Delegate Methods

- (void) tableViewDidUpdate:(UITableView *)tableView
{
    
}

#pragma mark - Getters and Setters

// Model
@synthesize course              = _course;

// View
@synthesize subjectTableView = _subjectTableView;
//@synthesize studensLabel        = _studentsLabel;
//@synthesize addStudentsButton   = _addStudentsButton;
//@synthesize noStudentsLabel     = _noStudentsLabel;

@end
