//
//  FilteredStudentCollectionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-09.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "FilteredStudentCollectionViewController.h"

// Model
#import "Course+Create.h"

// View
#import "CollectionViewCell.h"
#import "GraidAidCollectionViewCell.h"
#import "StudentInfoViewController.h"

// Controller
#import "AppDelegate.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "UIStoryboard+mainStoryboard.h"


@interface FilteredStudentCollectionViewController ()
{
    CollectionViewFetchedDataSource *_collectionViewFetchedDataSource;
}

@end

@implementation FilteredStudentCollectionViewController

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
    
    
    /* Setup Student FetchRequest */
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Student"];
    request.sortDescriptors = [Student lastNameSortDescriptors];
    request.predicate = [self predicateWithFilter];
    
    /* Setup Student FetchedDataSource */
    _collectionViewFetchedDataSource = [[CollectionViewFetchedDataSource alloc] initWithCollectionView:self.collectionView fetchRequest: request delegate: self];
    [_collectionViewFetchedDataSource performFetch];
    self.collectionView.delegate = nil;
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
        [predicates addObject: [f studentPredicate]];
    }
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates: predicates];
    return predicate;
}

#pragma mark - CollectionViewFetchedDataSource Delegate Methods

- (UICollectionViewCell*) collectionViewCellForObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath
{
//    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: CollectionViewCellIdentifier forIndexPath:indexPath];
//
//    Student *student = (Student*) object;
//
//    cell.image = student.studentImage;
//    cell.title = student.fullName;
    
    
    GraidAidCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:StudentGradeAidCollectionViewCell forIndexPath: indexPath];
    
    __block Student *student = (Student*) object;
    
    cell.imageView.image = student.studentImage;
    cell.textLabel.text = student.fullName;

    [cell setEditMode: _editMode];
    
    cell.cellTappedBlock = ^(UICollectionViewCell *cell, BOOL editMode)
    {
        if (!editMode)
        {
            StudentInfoViewController *sivc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"StudentInfoViewController"];
            [sivc setStudent: student];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: sivc];
            [nav setModalPresentationStyle: UIModalPresentationPageSheet];
            [nav setModalTransitionStyle: UIModalTransitionStyleCoverVertical];

            [self presentViewController: nav animated: YES completion: nil];
        }
    };
    cell.cellLongPressedBlock = ^(UICollectionViewCell *cell, BOOL editMode)
    {
        if (!_editMode)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName: FilteredStudentCollectionViewControllerDidEnterEditModeNotification object: nil];
        }
    };
    cell.deleteiconPressedBlock = ^(UICollectionViewCell* cell)
    {
        NSString *message = [NSString stringWithFormat: @"Är du säker på att du vill ta bort \"%@\"? All sparad information kommer förloras.", student.fullName];
        [UIAlertView alertViewWithTitle:@"Ta bort elev"
                                message: message
                      cancelButtonTitle:@"Nej"
                      otherButtonTitles:@[@"Ja"]
                              onDismiss:^(int buttonIndex)
         {
             [Student deleteStudent: student];
         }
                               onCancel:^()
         {
             NSLog(@"Cancelled");
         }];
    };
    
    return cell;
}

#pragma mark - UICollectionView Delgate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - View Appearance Methods

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateFetcherPredicate];
//    [self setupWithFilter];
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

- (void) setEditMode:(BOOL)editMode
{
    if (_editMode == editMode) return;
    _editMode = editMode;
    [self.collectionView reloadData];
}

@synthesize editMode = _editMode;
@synthesize filter = _filter;

@end
