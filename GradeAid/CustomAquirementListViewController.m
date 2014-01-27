//
//  CustomAquirementListViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CustomAquirementListViewController.h"

// Global
#import "Session.h"
#import "AppDelegate.h"

@interface CustomAquirementListViewController ()

@end

@implementation CustomAquirementListViewController

#pragma mark - Constructor Methods

#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_customAquirementTableView setTableViewDelegate: self];
    [_customAquirementTableView setCourse: _course];
    [_customAquirementTableView reloadData];
    
    [self reloadViews];
}

#pragma mark - IBAction Methods

- (IBAction) addTeacherAquirementDescriptionButton: (UIButton*) addAquirementDescriptionButton
{
    CourseEdition *courseEdition = _course.courseEdition;
    Teacher *teacher = [Session currentSession].teacher;
    NSString *caption = @"";
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    
    TeacherAquirementDescription *teacherAquirementDescirption = [TeacherAquirementDescription teacherAquirementDescriptionWithCourseDescription: courseEdition teacher: teacher caption: caption managedObjectContext: moc];
    
    [_customAquirementTableView selectForEditing: teacherAquirementDescirption];
}

#pragma mark - TableView Delegate Methods

- (void) tableViewDidUpdate:(UITableView *)tableView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) reloadViews
{
    _addAquirementDescriptionButton.alpha = (_inEditMode) ? 1.0 : 0.0;
    [_customAquirementTableView setInEditMode: _inEditMode];
}

#pragma mark - Getters and Setters

- (void) setInEditMode:(bool)inEditMode
{
    _inEditMode = inEditMode;
    [self reloadViews];
}

@synthesize inEditMode                      = _inEditMode;
@synthesize course                          = _course;
@synthesize customAquirementTableView       = _customAquirementTableView;
@synthesize aquirementDescriptionLabel      = _aquirementDescriptionLabel;
@synthesize addAquirementDescriptionButton  = _addAquirementDescriptionButton;
@synthesize noAquirementDescriptionsLabel   = _noAquirementDescriptionsLabel;


@end
