//
//  FilteredCourseCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilteredCourseCollectionViewController.h"

// View
#import "CollectionViewCell.h"
#import "CourseCollectionViewCell.h"
#import "CourseEnrollmentSuiteViewController.h"

// Model
#import "Course+Create.h"

//Global
#import "AppDelegate.h"


@interface FilteredCourseCollectionViewController ()
{
    CollectionViewFetchedDataSource *_collectionViewFetchedDataSource;
}

@end

@implementation FilteredCourseCollectionViewController

- (id)  initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /* Setup Course FetchRequest */
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Course"];
    request.sortDescriptors = [Course defaultSortDescriptors];
    request.predicate = [self predicateWithFilter];
    
    /* Setup Course FetchedDataSource */
    _collectionViewFetchedDataSource = [[CollectionViewFetchedDataSource alloc] initWithCollectionView:self.collectionView fetchRequest: request delegate: self];
    [_collectionViewFetchedDataSource performFetch];
}

- (void) updateFetcherPredicate
{
    _collectionViewFetchedDataSource.fetchRequest.predicate = [self predicateWithFilter];
    [_collectionViewFetchedDataSource performFetch];
}

- (NSPredicate*) predicateWithFilter
{
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    for (FilterItem *f in _filter.filterItems)
    {
        [predicates addObject: [f coursePredicate]];
    }
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates: predicates];
    return predicate;
}

#pragma mark -

- (UICollectionViewCell*) collectionViewCellForObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath
{
    CourseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: CourseCollectionViewCellIdentifier forIndexPath: indexPath];
    Course *course = (Course*) object;

    [cell setCourse: course];
    
    return cell;
}

#pragma mark - UICollectionView Delgate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Course *course = [_collectionViewFetchedDataSource objectAtIndexPath: indexPath];
    CourseEnrollmentSuiteViewController *cesvc = [[CourseEnrollmentSuiteViewController alloc] initWithCourse: course];
    cesvc.modalPresentationStyle = UIModalPresentationPageSheet;
    cesvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController: cesvc animated: YES completion: nil];
}

#pragma mark - View Appearance Methods

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateFetcherPredicate];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(filterDidUpdate:) name: FilterDidUpdateNotification object: _filter];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark - FilterDelegateUpdate

- (void) filterDidUpdate:(NSNotification*) notification
{
    [self updateFetcherPredicate];
}

#pragma mark - Setters and Getters

- (void) setFilter:(Filter *)filter
{
    _filter = filter;
}

@synthesize filter = _filter;

@end
