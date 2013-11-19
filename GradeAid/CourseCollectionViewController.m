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
static NSString *const CourseSegueIdentifier        = @"CourseSegueIdentifier";

@interface CourseCollectionViewController ()

@end

@implementation CourseCollectionViewController
{
    CollectionViewDataFetcher *courseDataFetcher;
    NSFetchedResultsController *courseDataFetchController;
    
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
//    if (_selectedSchool)
//    {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%@ = %@", KeyForSchool, _selectedSchool];
//        [schoolFetchRequest setPredicate: predicate];
//    }
    
    schoolFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    courseDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolFetchRequest managedObjectContext: moc sectionNameKeyPath: nil cacheName: nil];
    
    
    courseDataFetcher = [[CollectionViewDataFetcher alloc]
                              initWithFetchedResultsController:courseDataFetchController
                              collectionView: _courseCollectionView
                              cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                                  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath: indexPath];
                                  Course *course = (Course*)[courseDataFetchController objectAtIndexPath: indexPath];
                                  cell.title = course.name;
                                  cell.image = nil;
                                  return cell;
                              }];
}

#pragma mark - CollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCourse = (Course*)[courseDataFetchController objectAtIndexPath: indexPath];

    [self performSegueWithIdentifier:CourseSegueIdentifier sender:self];
    
//    CourseTableViewController *courseTableViewController = (CourseTableViewController*)[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: CourseTableStoryBoardIdentifier];
//
//    UINavigationController *courseNavigationController = [[UINavigationController alloc] initWithRootViewController: courseTableViewController];
//
//    EnrollmentViewController *enrollmentViewController = (EnrollmentViewController*)[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: EnrollmentStoryboardIdentifier];
//    
//    UINavigationController *enrollmentNavigationController = [[UINavigationController alloc] initWithRootViewController: enrollmentViewController];
//    
//    [enrollmentViewController setCourse: _selectedCourse];
//    [courseTableViewController setEnrollmentViewController: enrollmentViewController];
//    
//    [enrollmentViewController setEnrollment: _selectedCourse.enrollments.allObjects.lastObject];
//    
//    UISplitViewController *splitController = [[UISplitViewController alloc] init];
//    
//    [splitController setViewControllers: @[courseNavigationController, enrollmentNavigationController]];
//
//    UIWindow *window = [AppDelegate sharedDelegate].window;
//    [window setRootViewController: splitController];
    
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
            CourseDescription *desc = (CourseDescription*) object;
            _selectedCourseDescription = desc;
            [self performSegueWithIdentifier: CourseEditionSegueIdentifier sender: self];
        }];
    }
    else if ([segue.identifier isEqualToString: CourseEditionSegueIdentifier])
    {
        [currentPopoverController dismissPopoverAnimated: YES];
        
        CourseEditionViewController *cevc = (CourseEditionViewController*) segue.destinationViewController;
        [cevc setTitle: @"Lägg till ny kurs"];
        [cevc setCourseDescription: _selectedCourseDescription];
        _selectedCourseDescription = nil;
    }
    else if ([segue.identifier isEqualToString: CourseSegueIdentifier])
    {
        CourseViewController *cvc = (CourseViewController*) segue.destinationViewController;
        [cvc setCourse: _selectedCourse];
        _selectedCourse = nil;
    }
}


@end
