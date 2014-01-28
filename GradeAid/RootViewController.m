//
//  RootViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2014-01-07.
//  Copyright (c) 2014 Daniel Hallin. All rights reserved.
//

#import "RootViewController.h"

// View
#import "FilterItemViewController.h"
#import "ItemCollectionViewCell.h"
#import "FilteredCourseCollectionViewController.h"
#import "FilteredStudentCollectionViewController.h"

#import "SchoolViewController.h"
#import "SchoolClassViewController.h"
#import "CourseViewController.h"

#import "PromptNavigationController.h"
#import "PromptCreateViewController.h"
#import "CreateStudentPromptViewController.h"
#import "SelectCourseDescriptionPromptViewController.h"
#import "CourseEnrollmentSuiteViewController.h"

#import "UIAlertView+MKBlockAdditions.h"
#import "Session.h"

#import "LoginViewController.h"
// Global
#import "UIStoryboard+mainStoryboard.h"
static CGFloat topMargin = 80.f;
static CGFloat cellWidth = 150.f;

@interface RootViewController ()
{
    FilteredCourseCollectionViewController *_filteredCourseCollectionViewController;
    FilteredStudentCollectionViewController *_filteredStudentCollectionViewController;
    
    FilterItemViewController *_currentFilterViewController;
    __block FilterItem *_selectedFilterItem;
    
    UIPopoverController *currentPopoverController;
    bool popOverIsShowing;
}

@property (nonatomic, strong) Filter *filter;

@end

@implementation RootViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _filter = [[Filter alloc] init];
        
        _filteredCourseCollectionViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"FilteredCourseCollectionViewController"];
        [_filteredCourseCollectionViewController setFilter: _filter];
        
        _filteredStudentCollectionViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"FilteredStudentCollectionViewController"];
        [_filteredStudentCollectionViewController setFilter: _filter];
        
        [self setViewControllers: @[_filteredCourseCollectionViewController, _filteredStudentCollectionViewController]];
        [self setViewControllerTitles: @[@"Ämnen", @"Elever"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_filterItemCollectionView reloadData];
    [_filterItemCollectionView setUserInteractionEnabled: YES];
}

#pragma mark - IBAction Methods

- (IBAction) addCourseButtonPressed:(id) sender
{
    [self performSegueWithIdentifier: PlusButtonPressed sender: self];
}

- (IBAction) logoutButtonPressed: (id)sender
{
    [UIAlertView alertViewWithTitle:@"Loggar ut"
                            message: @"Är du säker på att du vill logga ut?"
                  cancelButtonTitle:@"Nej"
                  otherButtonTitles:@[@"Ja"]
                          onDismiss:^(int buttonIndex)
     {
         [[NSNotificationCenter defaultCenter] postNotificationName: TeacherWillLogOutNotification object: [Session currentSession].teacher];
     }
                           onCancel:^()
     {
         NSLog(@"Cancelled");
     }];
}

#pragma mark - PlusButton Delegate Methods

- (void) plusTableViewController:(id)plusTableViewController plusButtonSelectedIndex:(NSInteger)index
{
    [currentPopoverController dismissPopoverAnimated: YES];

    PromptNavigationController *pnc = [[PromptNavigationController alloc] init];
    [pnc.view setOpaque: NO];
    [pnc setModalPresentationStyle: UIModalPresentationPageSheet];
    
    switch (index) {
        case createCourseIndex:
        {
            SelectCourseDescriptionPromptViewController *scdpvc = [[SelectCourseDescriptionPromptViewController alloc] init];
            [scdpvc setDoneSelectingBlock:^(PromptViewController *pvc, id object)
             {
                 CourseEnrollmentSuiteViewController *cesvc = [[CourseEnrollmentSuiteViewController alloc] initWithCourseDescription: (CourseDescription*) object];
                 cesvc.modalPresentationStyle = UIModalPresentationPageSheet;
                 cesvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                 [self dismissViewControllerAnimated: YES completion:^{
                     [self presentViewController: cesvc animated: YES completion: nil];
                 }];
             }];
            [pnc pushPromptViewController: scdpvc animated: YES];
            [self presentViewController: pnc animated: YES completion: nil];

            break;
        }
        case createStudentIndex:
        {
            CreateStudentPromptViewController *cspvc = [[CreateStudentPromptViewController alloc] initWithFilter: _filter];
            [cspvc setDoneCreatingBlock:^(PromptViewController *pvc, id object)
            {
                [_filteredStudentCollectionViewController viewDidAppear: YES];
                [pvc dismiss];
            }];
            [pnc pushPromptViewController: cspvc animated: YES];
            [self presentViewController: pnc animated: YES completion: nil];
            
            break;
        }
        case createSchoolIndex:
        {
            PromptCreateViewController *pcvc =  _filter.schoolFilterItem.newObjectPromptViewController;
            [pcvc setDoneCreatingBlock:^(PromptViewController *pcvc, id object)
             {
                 [_filter filterItemDidUpdate: _filter.schoolFilterItem];
                 [pcvc dismiss];
             }];
            [pnc pushPromptViewController: pcvc animated: YES];
            [self presentViewController: pnc animated: YES completion: nil];
            break;
        }
        case createSchoolClassIndex:
        {
            PromptCreateViewController *pcvc =  _filter.schoolClassFilterItem.newObjectPromptViewController;
            [pcvc setDoneCreatingBlock:^(PromptViewController *pcvc, id object)
             {
                 [_filter filterItemDidUpdate: _filter.schoolClassFilterItem];
                 [pcvc dismiss];
             }];
            [pnc pushPromptViewController: pcvc animated: YES];
            [self presentViewController: pnc animated: YES completion: nil];
            break;
        }
        case createCourseDescription:
        {
            break;
        }
    }
    
}

#pragma mark - Segue Methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: PlusButtonPressed])
    {
        PlusTableViewController *ptvc = segue.destinationViewController;
        [ptvc setDelegate: self];
        UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *)segue;
        currentPopoverController = popoverSegue.popoverController;    }
}

#pragma mark - Segmented NavigationController Methods

- (CGRect) subviewControllerFrame
{
    CGRect frame = UIEdgeInsetsInsetRect(_mainView.frame, UIEdgeInsetsMake(topMargin, 0, 0, 0));
    
    return frame;
}

#pragma mark - CollectionView DataSource Methods

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier: ItemCollectionViewCellIdentifier forIndexPath: indexPath];
    FilterItem *filterItem = [_filter.filterItems objectAtIndex: indexPath.item];
    
    [cell.imageView setImage: filterItem.imageForSelectedItem];
    [cell.label setText: filterItem.titleForSelectedItem];
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _filter.filterItems.count;
}

#pragma mark - CollectionView Delegate Methods
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath: indexPath animated: NO];
    FilterItem *filterItem = [_filter.filterItems objectAtIndex: indexPath.item];
    
    if ([filterItem isEqual: _selectedFilterItem])
    {
        _selectedFilterItem = nil;
        [self presentFilterItemViewController: nil];
    }
    else
    {
        _selectedFilterItem = filterItem;
        FilterItemViewController *filterItemViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"FilterItemViewController"];
        [filterItemViewController setFilterItem: _selectedFilterItem];
        [filterItemViewController setDismissBlock:^(){
            _selectedFilterItem = nil;
            [self presentFilterItemViewController: nil];
        }];
        
        [self presentFilterItemViewController: filterItemViewController];
    }
}

#pragma mark - Helper Methods

- (void) presentFilterItemViewController: (FilterItemViewController*) filterItemViewController
{
    [self.view bringSubviewToFront: _filterItemPresentationView];
    
    FilterItemViewController *previousFilterItemViewController = _currentFilterViewController;
    _currentFilterViewController = filterItemViewController;
    [_currentFilterViewController.view setClipsToBounds: YES];

    CGRect currentViewStartFrame = _filterItemPresentationView.bounds;
    currentViewStartFrame.size.height = 0;
    currentViewStartFrame.origin.y = _filterItemPresentationView.frame.size.height;

    CGRect currentViewEndFrame = _filterItemPresentationView.bounds;

    CGRect previousViewEndFrame = _filterItemPresentationView.bounds;
    previousViewEndFrame.size.height = 0;
    previousViewEndFrame.origin.y = _filterItemPresentationView.frame.size.height;

    _currentFilterViewController.view.frame = currentViewStartFrame;
    
    _currentFilterViewController.view.translatesAutoresizingMaskIntoConstraints = NO;

    [_filterItemPresentationView addSubview: _currentFilterViewController.view];
    [_currentFilterViewController didMoveToParentViewController: self];

    if (_currentFilterViewController)
    {
        UIView *subview = _currentFilterViewController.view;
        NSDictionary *views = NSDictionaryOfVariableBindings(subview);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }

    [UIView animateWithDuration: 0.3 animations:^{
        _currentFilterViewController.view.frame = currentViewEndFrame;
        if (_currentFilterViewController && previousFilterItemViewController)
        {
            previousFilterItemViewController.view.alpha = 0.1;
        } else {
            previousFilterItemViewController.view.frame = previousViewEndFrame;
        }
        
        
    } completion:^(BOOL finished) {
        [previousFilterItemViewController.view removeFromSuperview];
        [previousFilterItemViewController removeFromParentViewController];
        [self updateViewConstraints];
    }];
}

#pragma mark - Segmented NavigationController Methods

- (void) willPresentViewControllerWithIndex:(NSInteger)index
{
    _selectedFilterItem = nil;
    [self presentFilterItemViewController: nil];
}

#pragma mark - View Appearance Methods

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    CGFloat cellWidthSum = _filter.filterItems.count * cellWidth;
    
    if (cellWidthSum < self.filterItemCollectionView.frame.size.width)
    {
        CGFloat collectionViewWidth = self.filterItemCollectionView.frame.size.width;
        CGFloat leftInset = (collectionViewWidth - cellWidthSum) / 2;
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)_filterItemCollectionView.collectionViewLayout;
        [flowLayout setSectionInset: UIEdgeInsetsMake(0, leftInset, 0, 0)];
        [_filterItemCollectionView setCollectionViewLayout: flowLayout];
    }
    
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
    [_filterItemCollectionView reloadData];
}

#pragma mark - Getters and Setters

// View
@synthesize filterItemCollectionView = _filterItemCollectionView;
@synthesize mainView = _mainView;

// Model
@synthesize filter = _filter;

@end
