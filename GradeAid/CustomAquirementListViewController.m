//
//  CustomAquirementListViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-12-20.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CustomAquirementListViewController.h"
#import "AquirementDescription+Create.h"
#import "AppDelegate.h"
#import "TeacherAquirementDescriptionEditCell.h"
#import "RoundCorners.h"

// Global
#import "Session.h"
#import "AppDelegate.h"


static NSString *const TeacherAquirementCellIdentifier = @"TeacherAquirementCellIdentifier";

@interface CustomAquirementListViewController ()

@end

@implementation CustomAquirementListViewController

#pragma mark - Constructor Methods


#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_customAquirementTableView setDelegate: self];
    [_customAquirementTableView setDataSource: self];

    _customAquirements = [[NSMutableArray alloc] init];

    [self refreshData];
    [self reloadViews];
}

#pragma mark - IBAction Methods

- (IBAction) addTeacherAquirementDescriptionButton: (UIButton*) addAquirementDescriptionButton
{
    TeacherAquirementDescription *tad = [TeacherAquirementDescription teacherAquirementDescriptionWithCourseDescription: _course.courseEdition teacher: [Session currentSession].teacher caption: @"" managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    
    NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_customAquirementTableView beginUpdates];
    [_customAquirements insertObject: tad atIndex: 0];
    [_customAquirementTableView insertRowsAtIndexPaths: @[firstIndex] withRowAnimation: UITableViewRowAnimationAutomatic];
    [_customAquirementTableView endUpdates];
    
    [self tableView: _customAquirementTableView didSelectRowAtIndexPath: firstIndex];
}

- (void) refreshData
{
    self.customAquirements = _course.teacherAquirementDescriptions;
}

#pragma mark - TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [RoundCorners tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _customAquirements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __block TeacherAquirementDescription *aqDesc = [_customAquirements objectAtIndex: indexPath.row];
    
    if (_inEditMode)
    {
        TeacherAquirementDescriptionEditCell *cell = [tableView dequeueReusableCellWithIdentifier: TeacherAquirementEditCellIdentifier forIndexPath:indexPath];
        [cell setTeacherAquirementDescription: aqDesc];
        
        cell.deleteAquirementBlock = ^{
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                if ([TeacherAquirementDescription deleteTeacherAquirement: aqDesc])
                {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        int index = [_customAquirements indexOfObject: aqDesc];
                        
                        [tableView beginUpdates];
                        [_customAquirements removeObjectAtIndex: index];
                        [tableView deleteRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: index inSection:0]]withRowAnimation: UITableViewRowAnimationAutomatic];
                        [tableView endUpdates];                    });
                }
            });
        };
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TeacherAquirementCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setText: aqDesc.caption];
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [RoundCorners tableView: tableView willDisplayCell: cell forRowAtIndexPath:indexPath];
    
}

- (void) reloadViews
{
    _addAquirementDescriptionButton.alpha = (_inEditMode) ? 1.0 : 0.0;
    self.customAquirements = _course.teacherAquirementDescriptions;
    [_customAquirementTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_inEditMode)
    {
        TeacherAquirementDescriptionEditCell *cell = (TeacherAquirementDescriptionEditCell*)[tableView cellForRowAtIndexPath: indexPath];
        [cell.textField becomeFirstResponder];
    }
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
@synthesize customAquirements               = _customAquirements;

- (void) setCustomAquirements:(NSArray *)customAquirements
{
    [_customAquirements setArray: customAquirements];
}

@end
