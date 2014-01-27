//
//  SettingsViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-10-29.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//
#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "UIStoryboard+mainStoryboard.h"

#import "CollectionViewDataFetcher.h"
#import "CourseEditionCell.h"
#import "RegisterObjectViewController.h"
#import "SettingsCell.h"
#import "RegisterStudentViewController.h"
#import "PopupTableViewController.h"
#import "CourseEditionViewController.h"

#import "School+Create.h"
#import "SchoolClass+Create.h"
#import "Student+Create.h"
#import "CourseDescription+Create.h"

static int const TagForCourseEditionSection = 11;
static int const TagForSchoolSection = 12;
static int const TagForSchoolClassSection = 13;
static int const TagForStudentSection = 14;

static NSString *const IdentifierForSegueCreateCourseEdition = @"IdentifierForSegueCreateCourseEdition";
static NSString *const IdentifierForSegueCreateSchool        = @"IdentifierForSegueCreateSchool";
static NSString *const IdentifierForSegueCreateSchoolClass   = @"IdentifierForSegueCreateSchoolClass";
static NSString *const IdentifierForSegueCreateStudent       = @"IdentifierForSegueCreateStudent";

static NSString *const IdentifierForCoursePopup              = @"CoursePopupSegueIdentifier";

@interface SettingsViewController ()
{

    CollectionViewDataFetcher *schoolDataFetcher;
    CollectionViewDataFetcher *schoolClassDataFetcher;
    CollectionViewDataFetcher *studentDataFetcher;
    
    NSFetchedResultsController *studentDataFetchController;
    
    UIPopoverController *currentPopoverController;
}

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    return;
    managedObjectContext = [AppDelegate sharedDelegate].managedObjectContext;

    [courseEditionsCollectionView.layer setCornerRadius: 10.f];
    [courseEditionsCollectionView.layer setMasksToBounds: YES];
    
    [schoolClassCollectionView reloadData];
    [courseEditionsCollectionView reloadData];
    
    /* Fetch schools */
    
    NSFetchRequest *schoolFetchRequest = [[NSFetchRequest alloc] init];
    [schoolFetchRequest setEntity: [NSEntityDescription entityForName: @"School" inManagedObjectContext:managedObjectContext]];

    
    
    schoolFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    NSFetchedResultsController *schoolDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolFetchRequest managedObjectContext: managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    
    schoolDataFetcher = [[CollectionViewDataFetcher alloc]
                            initWithFetchedResultsController:schoolDataFetchController
                                              collectionView:schoolCollectionView
                                                   cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
        SettingsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: SettingsCellIdentifier forIndexPath: indexPath];
        School *school = (School*)[schoolDataFetchController objectAtIndexPath: indexPath];
        cell.title = school.name;
        cell.thumbNail = [UIImage imageWithData: school.image];
        return cell;
    }];
    
    /* Fetch schools classes */
    
    NSFetchRequest *schoolClassFetchRequest = [[NSFetchRequest alloc] init];
    [schoolClassFetchRequest setEntity: [NSEntityDescription entityForName: @"SchoolClass" inManagedObjectContext:managedObjectContext]];
    
    
    
    schoolClassFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES]];
    
    NSFetchedResultsController *classDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: schoolClassFetchRequest managedObjectContext: managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    
    schoolClassDataFetcher= [[CollectionViewDataFetcher alloc]
                         initWithFetchedResultsController:classDataFetchController
                         collectionView:schoolClassCollectionView
                         cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                             SettingsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: SettingsCellIdentifier forIndexPath: indexPath];
                             SchoolClass *schoolClass = (SchoolClass*)[classDataFetchController objectAtIndexPath: indexPath];
                             cell.title = schoolClass.school.name;
                             cell.number = schoolClass.year;
                             return cell;
                         }];
    
    
    
    /* Fetch Students */
    
    NSFetchRequest *studentFetchRequest = [[NSFetchRequest alloc] init];
    [studentFetchRequest setEntity: [NSEntityDescription entityForName: @"Student" inManagedObjectContext:managedObjectContext]];
    
    
    
    studentFetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"firstName" ascending: YES]];
    
    studentDataFetchController = [[NSFetchedResultsController alloc] initWithFetchRequest: studentFetchRequest managedObjectContext: managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    
    studentDataFetcher = [[CollectionViewDataFetcher alloc]
                         initWithFetchedResultsController:studentDataFetchController
                         collectionView:studentCollectionView
                         cellBlock: ^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
                             SettingsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: SettingsCellIdentifier forIndexPath: indexPath];
                             Student *student = (Student*)[studentDataFetchController objectAtIndexPath: indexPath];
                             cell.title = student.title;
                             cell.thumbNail = student.thumbNail;
                             return cell;
                         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CourseEditionCellIdentifier forIndexPath: indexPath];
    return cell;
}

- (IBAction)logout:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: IdentifierForSegueCreateCourseEdition])
    {
//        RegisterObjectViewController *rvc = ((RegisterObjectViewController*) segue.destinationViewController);
//        [rvc setObjectVerifyer: [School objectVerifyer]];
//        [rvc setManagedObjectContext: managedObjectContext];
    }
    else if ([segue.identifier isEqualToString: IdentifierForSegueCreateSchool])
    {
        RegisterObjectViewController *rvc = ((RegisterObjectViewController*) segue.destinationViewController);
        [rvc setObjectVerifyer: [School objectVerifyer]];
        [rvc setManagedObjectContext: managedObjectContext];
        [rvc setTitle: @"Skapa ny skola"];

    }
    else if ([segue.identifier isEqualToString: IdentifierForSegueCreateSchoolClass])
    {
        RegisterObjectViewController *rvc = ((RegisterObjectViewController*) segue.destinationViewController);
        [rvc setObjectVerifyer: [SchoolClass objectVerifyer]];
        [rvc setManagedObjectContext: managedObjectContext];
        [rvc setTitle: @"Skapa ny klass"];
    }
    else if ([segue.identifier isEqualToString: IdentifierForSegueCreateStudent])
    {
//        RegisterObjectViewController *rvc = ((RegisterObjectViewController*) segue.destinationViewController);
//        [rvc setObjectVerifyer: [School objectVerifyer]];
//        [rvc setManagedObjectContext: managedObjectContext];
    }
    
    else if ([segue.identifier isEqualToString: IdentifierForCoursePopup])
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
            CourseEditionViewController *cevc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"CourseEditionViewController"];
            [cevc setTitle: @"Lägg till ny kurs"];
            [cevc setCourseDescription: desc];
            [cevc setModalPresentationStyle: UIModalPresentationPageSheet];
            [self presentViewController: cevc animated: YES completion:^{
                [currentPopoverController dismissPopoverAnimated: YES];
            }];
        }];
        [ptvc setClearOnSelection: YES];
    }
}

- (IBAction) addCourseEdition:(id)sender
{

}
- (IBAction) addSchoolClass: (id)sender
{}
- (IBAction) addStudent:(id)sender
{}

#pragma mark - UICollectionView Delegate Methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == studentCollectionView)
    {
        RegisterStudentViewController *rsvc = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier: @"StudentViewController"];
        
        [rsvc setModalPresentationStyle: UIModalPresentationFormSheet];
        [rsvc setStudent: [studentDataFetchController objectAtIndexPath: indexPath]];
        
        [self presentViewController: rsvc animated: YES completion: nil];
    }
}

#pragma mark - Helper Methods

@end
