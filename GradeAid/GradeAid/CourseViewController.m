//
//  CourseViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-13.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseViewController.h"

/* Global */

#import "AppDelegate.h"
#import "Session.h"
#import "UIStoryboard+mainStoryboard.h"

/* Model */

#import "CourseDescription+Create.h"
#import "Subject+Create.h"
#import "SchoolClass+Create.h"
#import "School+Create.h"
#import "Course+Create.h"
#import "CourseEdition+Create.h"
#import "Enrollment+Create.h"

/* View */

#import "EnrollmentListViewController.h"
#import "CustomAquirementListViewController.h"
#import "SubjectViewController.h"
#import "MultiSegmentedNavigationController.h"

/* Helper */

#import "UIAlertView+MKBlockAdditions.h"
#import "AttributeFormatter.h"
#import "AttributeVerifyer.h"

static CGRect SubViewControllerFrame = {0, 97, 768, 927};

static NSString *const SchoolClassCellIdentifier  = @"SchoolClassCellIdentifier";
static NSString *const SelectClassSegueIdentifier = @"SelectClassSegueIdentifier";
static NSString *const SelectStudentsIdentifier   = @"SelectStudentsIdentifier";

static NSString *const SaveTitle    = @"Klar";
static NSString *const EditTitle    = @"Ändra";
static NSString *const DeleteTitle  = @"Ta bort";
static NSString *const CancelTitle  = @"Avbryt";
static NSString *const DoneTitle    = @"Klar";

@interface CourseViewController ()
{
    bool subjectSectionExpanded;
    bool subjectObjectiveCaptionRowExpanded;
    bool subjectIntroCaptionRowExpanded;
    
    bool courseSectionExpanded;
    
    NSInteger _currentSegmentIndex;
    UIViewController *_currentViewController;
    
    EnrollmentListViewController *_enrollmentListViewController;
    CustomAquirementListViewController *_customAquirementListViewController;
    SubjectViewController *_subjectViewController;
    MultiSegmentedNavigationController *_aquirementViewController;
    
    UIBarButtonItem *_saveButton;
    UIBarButtonItem *_doneButton;
    UIBarButtonItem *_cancelButton;
    UIBarButtonItem *_editButton;
    UIBarButtonItem *_deleteButton;
}

@property (nonatomic, strong) EnrollmentListViewController *enrollmentListViewController;
@property (nonatomic, strong) CustomAquirementListViewController *customAquirementListViewController;
@property (nonatomic, strong) SubjectViewController *subjectViewController;

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation CourseViewController

#pragma mark - Constructor Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self initialize];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    _enrollmentListViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"EnrollmentListViewController"];
    
    _customAquirementListViewController  = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CustomAquirementListViewController"];
    
    _subjectViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SubjectViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titleLabel.text = (_inCreateMode) ? @"Skapa ny kurs" : _course.name;
    _titleTextField.text = (_inCreateMode) ? @"Skapa ny kurs" : _course.name;
    
    /* Toolbar */
    
    _saveButton =   [[UIBarButtonItem alloc] initWithTitle: SaveTitle   style: UIBarButtonItemStyleDone target: self action:@selector(saveButtonPressed:)];
    _cancelButton = [[UIBarButtonItem alloc] initWithTitle: CancelTitle style: UIBarButtonItemStylePlain target: self action:@selector(cancelButtonPressed:)];
    _doneButton =   [[UIBarButtonItem alloc] initWithTitle: DoneTitle   style: UIBarButtonItemStylePlain target: self action:@selector(doneButtonPressed:)];
    _deleteButton = [[UIBarButtonItem alloc] initWithTitle: DeleteTitle style: UIBarButtonItemStylePlain target: self action:@selector(deleteButtonPressed:)];
    _editButton =   [[UIBarButtonItem alloc] initWithTitle: EditTitle   style: UIBarButtonItemStylePlain target: self action:@selector(editButtonPressed:)];
    
    [_deleteButton setTintColor: [UIColor redColor]];
    
    /* Subviews */
    
    [_enrollmentListViewController setCourse: _course];
    [_customAquirementListViewController setCourse: _course];
    [_subjectViewController setCourse: _course];
    
    [_currentViewController removeFromParentViewController];
    [_currentViewController.view removeFromSuperview];
    
    _currentSegmentIndex = 0;
    [_segmentedControl setSelectedSegmentIndex: _currentSegmentIndex];
    _currentViewController = [self viewControllerForSegmentIndex: _currentSegmentIndex];
    _currentViewController.view.frame = SubViewControllerFrame;
    
    [self addChildViewController: _currentViewController];
    [self.view addSubview: _currentViewController.view];
    
    [self reloadViews];
}

#pragma mark - IBAction Methods

static int const transitionDirectionLeft  = 1;
static int const transitionDirectionRight = 2;

- (IBAction)segmentChanged:(UISegmentedControl *)sender
{
    NSInteger previousSegmentIndex = _currentSegmentIndex;
    _currentSegmentIndex = sender.selectedSegmentIndex;
    
    UIViewController *previousViewController = _currentViewController;
    _currentViewController = [self viewControllerForSegmentIndex: _currentSegmentIndex];

    int transitionDirection = (previousSegmentIndex < _currentSegmentIndex) ? transitionDirectionLeft : transitionDirectionRight;
    
    CGRect currentVCStartingFrame = SubViewControllerFrame;
    CGRect previousVCEndingFrame  = SubViewControllerFrame;
    
    if (transitionDirection == transitionDirectionLeft)
    {
        currentVCStartingFrame.origin.x += SubViewControllerFrame.size.width;
        previousVCEndingFrame.origin.x -= SubViewControllerFrame.size.width;
    }
    else if (transitionDirection == transitionDirectionRight)
    {
        currentVCStartingFrame.origin.x -= SubViewControllerFrame.size.width;
        previousVCEndingFrame.origin.x += SubViewControllerFrame.size.width;
    }
    
    [self addChildViewController: _currentViewController];
    _currentViewController.view.frame = currentVCStartingFrame;
    [self.view addSubview: _currentViewController.view];
    
    [UIView animateWithDuration: 0.4 animations:^{
        [_currentViewController.view setFrame: SubViewControllerFrame];
        [previousViewController.view setFrame: previousVCEndingFrame];
    } completion:^(BOOL finished) {
        [previousViewController.view removeFromSuperview];
        [_currentViewController didMoveToParentViewController: self];
        [previousViewController removeFromParentViewController];
    }];
}

#pragma mark - Helper Methods

- (UIViewController*) viewControllerForSegmentIndex: (NSInteger) index
{
    switch (index)
    {
        case 0:  return _enrollmentListViewController;
        case 1:  return _customAquirementListViewController;
        case 2:  return _subjectViewController;
        default: return nil;
    }
}

#pragma mark - TableView Delegate Methods

- (void) tableViewDidUpdate:(UITableView *)tableView
{
    [self performSelector: @selector(updateView:) withObject: tableView afterDelay: 0.0];
}

- (void) updateView: (UITableView*) tableView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        //        if ([tableView isEqual: _subjectTableView])
        //        {
        //            _subjectTableViewHeight.constant = [_subjectTableView height];
        //        }
        //        else if ([tableView isEqual: _enrollmentTableView])
        //        {
        //            _enrollmentTableViewHeight.constant = [_enrollmentTableView height];
        //        }
        [self.view needsUpdateConstraints];
    }];
}

#pragma mark - IBAction Methods

- (IBAction) saveButtonPressed: (id)sender
{
    if ([self controlTitle])
    {
        [self saveCourse];
        [self setInNormalMode];
    }
}

- (IBAction) cancelButtonPressed: (id)sender
{
    if (_inCreateMode)
    {
        NSManagedObjectContext *moc =  [AppDelegate sharedDelegate].managedObjectContext;
        [moc deleteObject: _course];
        [[NSNotificationCenter defaultCenter] postNotificationName: WillDismissViewControllerNotifification object: self];
    }
    else
    {
        [self setInEditMode: NO];
        [self setInCreateMode: NO];
    }
}

- (IBAction) doneButtonPressed: (id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: WillDismissViewControllerNotifification object: self];
//    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) editButtonPressed: (id)sender
{
    [self setInEditMode: YES];
}

- (IBAction) deleteButtonPressed: (id)sender
{
    [UIAlertView alertViewWithTitle:@""
                            message:@"Är du säker på att du vill ta bort kursen?"
                  cancelButtonTitle:@"Nej"
                  otherButtonTitles:@[@"Ja"]
                          onDismiss:^(int buttonIndex)
     {
         [self deleteCourse];
         [[NSNotificationCenter defaultCenter] postNotificationName: WillDismissViewControllerNotifification object: self];
     }
                           onCancel:^()
     {
         NSLog(@"Cancelled");
     }];
}

//#pragma mark - Student Was Selected Method
//
//- (void) enrollmentWasSelected: (NSNotification*) notification
//{
//    Enrollment *enrollment = notification.object;
//    NSLog(@"Student %@ was selected", enrollment.student.title);
//}
//
//#pragma mark - Notification Preparation Methods
//
//- (void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear: animated];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(enrollmentWasSelected:) name:EnrolllmentWasSelectedNotification object: nil];
//}
//
//- (void) viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear: animated];
//    [[NSNotificationCenter defaultCenter] removeObserver: self];
//}

#pragma mark - State Methods

- (void) setInNormalMode
{
    _titleLabel.text = _course.name;
    _inEditMode = NO;
    _inCreateMode = NO;
    [self reloadViews];
}

- (void) setInEditMode:(bool)inEditMode
{
    _titleTextField.text = _course.name;
    _inEditMode = inEditMode;
    [self reloadViews];
}

- (void) setInCreateMode:(bool)inCreateMode
{
    _inCreateMode = inCreateMode;
    if (!_titleItem) return; // fulhack, för att se till att vyn synns för att reloadview
    [self reloadViews];
}

- (void) reloadViews
{
    /* Header */
    bool hideLabel = _inCreateMode || _inEditMode;
    [_titleTextField setHidden: !hideLabel];
    [_titleLabel setHidden: hideLabel];
    
    /* Toolbar */
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items;
    if (_inCreateMode)
    {
        _saveButton.title = @"Spara";
        items = @[_cancelButton, flexibleItem, _titleItem, flexibleItem, _saveButton];
    }
    else if (_inEditMode)
    {
        _saveButton.title = @"Klar";
        items = @[_deleteButton, flexibleItem, _titleItem, flexibleItem, _saveButton];
    }
    else
    {
        items = @[_doneButton, flexibleItem, _titleItem, flexibleItem, _editButton];
    }
    [_toolbar setItems: items animated: YES];
    
    /* Subviews */
    [_enrollmentListViewController setInEditMode: _inEditMode || _inCreateMode];
    [_customAquirementListViewController setInEditMode: _inEditMode || _inCreateMode];
}

#pragma mark - Helper Methods

- (void) saveCourse
{
    NSManagedObjectContext *moc =  [AppDelegate sharedDelegate].managedObjectContext;

    _course.name = _titleTextField.text;
//    for (Enrollment *e in _course.enrollments)
//    {
//        [e enrollInCourse: _course managedObjectContext: moc];
//    }
    [moc save: nil];
}

- (void) deleteCourse
{
    NSManagedObjectContext *moc =  [AppDelegate sharedDelegate].managedObjectContext;
    [moc deleteObject: _course];
    
    [moc save: nil];
}

- (bool) controlTitle
{
    bool titleOk = _titleTextField.text && _titleTextField.text.length;
    if (titleOk)
    {
        return YES;
    }
    [UIAlertView alertViewWithTitle:@"Felaktigt kursnamn"
                            message:@""
                  cancelButtonTitle:@"OK"
                  otherButtonTitles: nil
                          onDismiss: nil
                           onCancel: ^()
    {
        if (_course.name && _course.name.length)
        {
            [_titleTextField setText: _course.name];
        }
        [_titleTextField becomeFirstResponder];
    }];
    
    return NO;
}

#pragma mark - Getters and Setters

// Model
@synthesize course = _course;
@synthesize courseDescription = _courseDescription;

// State
@synthesize inEditMode = _inEditMode;
@synthesize inCreateMode = _inCreateMode;

// View
@synthesize toolbar = _toolbar;
@synthesize titleItem = _titleItem;
@synthesize titleLabel = _titleLabel;
@synthesize titleTextField = _titleTextField;
@synthesize segmentedControl = _segmentedControl;

@synthesize currentViewController = _currentViewController;

@synthesize enrollmentListViewController = _enrollmentListViewController;
@synthesize customAquirementListViewController = _customAquirementListViewController;
@synthesize subjectViewController = _subjectViewController;


@end
