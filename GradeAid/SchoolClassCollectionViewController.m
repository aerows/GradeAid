//
//  SchoolClassCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-15.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolClassCollectionViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "RegisterObjectViewController.h"
#import "AppDelegate.h"
#import "CollectionViewCell.h"
#import "CollectionViewDataFetcher.h"

#import "School+Create.h"

#import "PopupTableViewController.h"
#import "SchoolClassViewController.h"

#import "SchoolClass+Create.h"

#import "SettingsCell.h"

static NSString *const SchoolPopupSegueIdentifier = @"SchoolPopupSegueIdentifier";
static NSString *const SchoolClassSegueIdentifier = @"SchoolClassSegueIdentifier";

@implementation SchoolClassCollectionViewController
{
    CollectionViewDataFetcher *schoolClassDataFetcher;
    NSFetchedResultsController *schoolClassDataFetchController;
    
    UIPopoverController *currentPopoverController;
    
    SchoolClass *_selectedClass;
}

#pragma mark - Constructor Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    [self setupFetchResultsController];
    [_schoolClassCollectionView setDelegate: self];
    
}

- (void) setupFetchResultsController
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    NSFetchRequest *schoolFetchRequest = [[NSFetchRequest alloc] init];
    [schoolFetchRequest setEntity: [NSEntityDescription entityForName: @"SchoolClass" inManagedObjectContext:moc]];
    if (_selectedSchool)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%@ = %@", KeyForSchool, _selectedSchool];
        [schoolFetchRequest setPredicate: predicate];
    }
    
    schoolFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    schoolClassDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolFetchRequest managedObjectContext: moc sectionNameKeyPath: nil cacheName: nil];
    
    
    schoolClassDataFetcher = [[CollectionViewDataFetcher alloc]
                         initWithFetchedResultsController:schoolClassDataFetchController
                         collectionView: _schoolClassCollectionView
                         cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                             CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath: indexPath];
                             SchoolClass *schoolClass = (SchoolClass*)[schoolClassDataFetchController objectAtIndexPath: indexPath];
                             cell.title = schoolClass.name;
                             cell.image = nil;
                             return cell;
                         }];
}

#pragma mark - CollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedClass = (SchoolClass*)[schoolClassDataFetchController objectAtIndexPath: indexPath];
    [self performSegueWithIdentifier: SchoolClassSegueIdentifier sender: self];
}

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: SchoolPopupSegueIdentifier])
    {
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
        currentPopoverController = popoverSegue.popoverController;
        
        PopupTableViewController *ptvc = (PopupTableViewController*)segue.destinationViewController;
        
        [ptvc setObjects: [School schoolsForCurrentTeacher]];
        [ptvc setSetupCellWithObject:^(UITableViewCell *cell, NSManagedObject *object) {
            School *school = (School*) object;
            [cell.textLabel setText: school.name];
            [cell.detailTextLabel setText: @""];
        }];
        [ptvc setOnSelectObject:^(NSManagedObject *object) {
            School *school = (School*) object;
            _selectedSchool = school;
            [self performSegueWithIdentifier: SchoolClassSegueIdentifier sender: self];
        }];
    }
    else if ([segue.identifier isEqualToString: SchoolClassSegueIdentifier])
    {
        SchoolClassViewController *scvc = (SchoolClassViewController*) segue.destinationViewController;

        if (_selectedClass)
        {
            [scvc setSchoolClass: _selectedClass];
            _selectedClass = nil;
        }
        else
        {
            [scvc setSelectedSchool: _selectedSchool];
        }
        [currentPopoverController dismissPopoverAnimated: YES];
    }
}

#pragma mark - Getters and Setters

@synthesize schoolClassCollectionView = _schoolClassCollectionView;
@synthesize selectedSchool = _selectedSchool;
@end
