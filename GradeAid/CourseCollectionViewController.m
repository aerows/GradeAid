//
//  CourseCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-16.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseCollectionViewController.h"
#import "UIStoryboard+mainStoryboard.h"

#import "CourseEditionViewController.h"
#import "CourseViewController.h"
#import "CourseEnrollmentSuiteViewController.h"

#import "AppDelegate.h"
#import "CollectionViewCell.h"
#import "CollectionViewDataFetcher.h"

#import "PopupTableViewController.h"
#import "SchoolClassViewController.h"

#import "SchoolClass+Create.h"

#import "SettingsCell.h"

#import "CourseTableViewController.h"
#import "EnrollmentViewController.h"

static NSString *const CoursePopupSegueIdentifier   = @"CoursePopupSegueIdentifier";
static NSString *const CourseEditionSegueIdentifier = @"CourseEditionSegueIdentifier";

static NSString *const CourseDescriptionSegueIdentifier = @"CourseDescriptionSegueIdentifier";

static NSString *const CourseSegueIdentifier        = @"CourseSegueIdentifier";

@interface CourseCollectionViewController ()

@end

@implementation CourseCollectionViewController
{
    CollectionViewDataFetcher *courseDataFetcher;
    NSFetchedResultsController *courseDataFetchController;
    
    // State
    bool popOverIsShowing;
    UIPopoverController *currentPopoverController;
    
    /* Temporary Pointers */
    CourseDescription *_selectedCourseDescription;
    Course            *_selectedCourse;
    
}

#pragma mark - Constructor Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    [self setupFetchResultsController];
    [_courseCollectionView setDelegate: self];
}

- (void) setupFetchResultsController
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    NSFetchRequest *schoolFetchRequest = [[NSFetchRequest alloc] init];
    [schoolFetchRequest setEntity: [NSEntityDescription entityForName: @"Course" inManagedObjectContext:moc]];

    schoolFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    courseDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolFetchRequest managedObjectContext: moc sectionNameKeyPath: nil cacheName: nil];
    
    
    courseDataFetcher = [[CollectionViewDataFetcher alloc]
                              initWithFetchedResultsController:courseDataFetchController
                              collectionView: _courseCollectionView
                              cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                                  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath: indexPath];
                                  Course *course = (Course*)[courseDataFetchController objectAtIndexPath: indexPath];
                                  cell.title = course.name;
                                  cell.image = [course courseImage];
                                  return cell;
                              }];
}

#pragma mark - CollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCourse = (Course*)[courseDataFetchController objectAtIndexPath: indexPath];

    CourseEnrollmentSuiteViewController *cesvc = [[CourseEnrollmentSuiteViewController alloc] initWithCourse: _selectedCourse];
    cesvc.modalPresentationStyle = UIModalPresentationPageSheet;
    cesvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController: cesvc animated: YES completion: nil];
}

#pragma mark - IBAction Methods

- (IBAction) addCourseButtonPressed:(id) sender
{
    if (!popOverIsShowing)
    {
        [self performSegueWithIdentifier:CoursePopupSegueIdentifier sender: self];
        popOverIsShowing = YES;
    }
    else
    {
        [currentPopoverController dismissPopoverAnimated: YES];
        popOverIsShowing = NO;
    }
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: CoursePopupSegueIdentifier])
    {
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
        currentPopoverController = popoverSegue.popoverController;
        
        PopupTableViewController *ptvc = (PopupTableViewController*)segue.destinationViewController;
        
        NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
        [ptvc setObjects: [CourseDescription allCourseDescriptionsInManagedObjectContext: moc]];
        [ptvc setSetupCellWithObject:^(UITableViewCell *cell, NSManagedObject *object) {
            CourseDescription *desc = (CourseDescription*) object;
            [cell.textLabel setText: desc.title];
            [cell.detailTextLabel setText: @""];
        }];
        [ptvc setOnSelectObject:^(NSManagedObject *object) {
            [currentPopoverController dismissPopoverAnimated: YES];
            popOverIsShowing = NO;
            
            CourseEnrollmentSuiteViewController *cesvc = [[CourseEnrollmentSuiteViewController alloc] initWithCourseDescription: (CourseDescription*) object];
            cesvc.modalPresentationStyle = UIModalPresentationPageSheet;
            cesvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentViewController: cesvc animated: YES completion: nil];

        }];
    }
    else if ([segue.identifier isEqualToString: CourseEditionSegueIdentifier])
    {
        [currentPopoverController dismissPopoverAnimated: YES];
        popOverIsShowing = NO;
        
        CourseEditionViewController *cevc = (CourseEditionViewController*) segue.destinationViewController;
        [cevc setCourseDescription: _selectedCourseDescription];
        _selectedCourseDescription = nil;
    }
    else if ([segue.identifier isEqualToString: CourseSegueIdentifier])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        CourseViewController *cvc = (CourseViewController*) [nav.viewControllers objectAtIndex: 0];
        [cvc setCourse: _selectedCourse];
        _selectedCourse = nil;
    }
    else if ([segue.identifier isEqualToString: CourseDescriptionSegueIdentifier])
    {
        CourseEnrollmentSuiteViewController *cesvc = [[CourseEnrollmentSuiteViewController alloc] initWithCourseDescription: _selectedCourseDescription];
        cesvc.modalPresentationStyle = UIModalPresentationPageSheet;
        cesvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [currentPopoverController dismissPopoverAnimated: YES];
        popOverIsShowing = NO;
        
        CourseViewController *cvc = (CourseViewController*) segue.destinationViewController;
        
        [cvc setCourseDescription: _selectedCourseDescription];
        [cvc setCourse: _selectedCourse];
        
        _selectedCourse = nil;
        _selectedCourseDescription = nil;
    }
}

@end
