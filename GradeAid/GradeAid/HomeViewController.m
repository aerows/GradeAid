//
//  HomeViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-09-18.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "HomeViewController.h"
#import "SchoolViewController.h"
#import "UIStoryboard+mainStoryboard.h"
#import "School.h"
#import "RegisterObjectViewController.h"
#import "AppDelegate.h"
#import "CollectionViewCell.h"

@interface HomeViewController ()

- (void) addButtonPressed;

@end

@implementation HomeViewController

#pragma mark - Constructor Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]]];
    
    [self setupFetchResultsController];
    
    /* AddButton */
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action:@selector(addButtonPressed)];
    [self.navigationItem setRightBarButtonItem: addButton];
}

- (void) setupFetchResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"School"];
    [request setSortDescriptors: @[[NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                        managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void) addButtonPressed
{
    ObjectVerifyer *objectVerifyer = [School objectVerifyer];
    [objectVerifyer setDelegate: self];
    RegisterObjectViewController *rovc = [[RegisterObjectViewController alloc] initWithObjectVerifyer: objectVerifyer];
    
    [self presentViewController: rovc animated: YES completion: nil];
}

#pragma mark - ObjectVerifyer Delegate Methods

- (void) objectVerifyer:(id)sender createdObject:(id)object
{
    [self.collectionView reloadData];
}

- (void) objectVerifyerCanceled:(id)sender
{
    
}

#pragma mark - UICollectionView Data Source Methods

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath: indexPath];
    
    School* school = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell setSchool: school];
    
    return cell;
}

#pragma mark - CollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *classes = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 4; i++)
    {
        [classes addObject: [NSString stringWithFormat: @"Klass %d", i+indexPath.item]];
    }
    SchoolViewController *svc = [[SchoolViewController alloc] initWithNibName:@"SchoolViewController" bundle: nil];
    //[svc setClasses: classes];
    
    [self.navigationController pushViewController: svc animated: YES];
}

@end
