//
//  HomeViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "SchoolCollectionViewController.h"
#import "UIStoryboard+mainStoryboard.h"

#import "SchoolViewController.h"

#import "AppDelegate.h"
#import "CollectionViewCell.h"
#import "CollectionViewDataFetcher.h"

#import "SettingsCell.h"

static NSString *const SchoolSegueIdentifier = @"SchoolSegueIdentifier";

@interface SchoolCollectionViewController ()
{
    School *_selectedSchool;
}

- (void) addButtonPressed;

@end

@implementation SchoolCollectionViewController

#pragma mark - Constructor Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    [self setupFetchResultsController];
    [_schoolCollectionView setDelegate: self];
    
}

- (void) viewWillAppear: (BOOL)animated
{
    [_schoolCollectionView reloadData];
}

- (void) setupFetchResultsController
{
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    NSFetchRequest *schoolFetchRequest = [[NSFetchRequest alloc] init];
    [schoolFetchRequest setEntity: [NSEntityDescription entityForName: @"School" inManagedObjectContext:moc]];
    
#pragma warning - Predicate för aktuell lärare

    schoolFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    _schoolDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolFetchRequest managedObjectContext: moc sectionNameKeyPath: nil cacheName: nil];
    
    
    _schoolDataFetcher = [[CollectionViewDataFetcher alloc]
                         initWithFetchedResultsController:_schoolDataFetchController
                         collectionView:_schoolCollectionView
                         cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                             CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath: indexPath];
                             School *school = (School*)[_schoolDataFetchController objectAtIndexPath: indexPath];
                             cell.title = school.name;
                             cell.image = [school schoolImage];                             
                             return cell;
                         }];
}

#pragma mark - CollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath: indexPath animated: YES];
    _selectedSchool = (School*)[_schoolDataFetchController objectAtIndexPath: indexPath];
    [self performSegueWithIdentifier: SchoolSegueIdentifier sender: self];
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: SchoolSegueIdentifier])
    {
        SchoolViewController *svc = (SchoolViewController*) segue.destinationViewController;
        [svc setSchool: _selectedSchool];
#warning - Här bör man sätta en array av object och ett index istället.

    }
}

#pragma mark - Getters and Setters

@synthesize schoolCollectionView = _schoolCollectionView;
@synthesize schoolDataFetchController = _schoolDataFetchController;
@synthesize schoolDataFetcher = _schoolDataFetcher;

@end
