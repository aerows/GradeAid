//
//  CourseEditionViewController.m
//  GradeAid
//
//  Created by Daniel Hallin on 2013-11-13.
//  Copyright (c) 2013 Daniel Hallin. All rights reserved.
//

#import "CourseEditionViewController.h"
#import "CourseDescription+Create.h"
#import "Subject+Create.h"
#import "SchoolClass+Create.h"
#import "School+Create.h"
#import "Course+Create.h"

#import "AppDelegate.h"
#import "UIStoryboard+mainStoryboard.h"
#import "Session.h"

#import "SchoolTableViewController.h"

#import "AttributeCell.h"
#import "SellectionCell.h"
#import "PresentAttributeCell.h"
#import "TextTableViewCell.h"
#import "SubjectObjectiveTableViewCell.h"
#import "SubjectiveObjectiveHeaderTableViewCell.h"
#import "CentralContentTableViewCell.h"
#import "AquirementTableViewCell.h"
#import "ExpandableHeaderCell.h"


#import "SellectionViewController.h"
#import "SelectionTableViewController.h"

static NSInteger const SchoolClassSection       = 0;

static NSInteger const SubjectSection           = 1;
static NSInteger const SubjectObjectivesSection = 2;
static NSInteger const CourseEditionSection     = 3;
static NSInteger const CourseContentItemSection = 4;
static NSInteger const CourseAquirementSection  = 5;

static NSInteger const SubjectNameRow               = 0;
static NSInteger const SubjectIntroCaptionRow       = 1;
static NSInteger const SubjectObjectiveCaptionRow   = 2;

static NSString *const SchoolClassCellIdentifier  = @"SchoolClassCellIdentifier";
static NSString *const SelectClassSegueIdentifier = @"SelectClassSegueIdentifier";
static NSString *const SelectStudentsIdentifier   = @"SelectStudentsIdentifier";

@interface CourseEditionViewController ()
{
    bool subjectSectionExpanded;
    bool subjectObjectiveCaptionRowExpanded;
    bool subjectIntroCaptionRowExpanded;
    
    bool courseSectionExpanded;
}

@end

@implementation CourseEditionViewController

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
    [_titleLabel setText: self.title];
    
    NSManagedObjectContext *moc = [AppDelegate sharedDelegate].managedObjectContext;
    
    if (!_schoolClasses)
    {
        _schoolClasses = [[NSMutableArray alloc] init];
    }
    
    if (!_courseEdition && !_courseDescription)
    {
        NSLog(@"Error");
    }
    
    if (!_courseEdition)
    {
        _courseEdition = [CourseEdition courseEditionWithAttributes:@{} managedObjectContext: moc];
        
        Teacher *teacher = [Session currentSession].teacher;
        _courseEdition.teacher = teacher;
        _courseEdition.courseDescription = _courseDescription;
        [teacher addCourseEditionsObject: _courseEdition];
        
        NSError *error = nil;
        [moc save: &error];
        if (error)
        {
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }
    
    if (!_courseDescription)
    {
        _courseDescription = _courseEdition.courseDescription;
    }
    
    _subject = _courseDescription.subject;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView reloadData];
}

#pragma mark - UITableView Datasource Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case SchoolClassSection:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SchoolClassCellIdentifier];
            if (!_schoolClasses.count)
            {
                [cell.textLabel setText: @"Ingen klass vald"];
                [cell.detailTextLabel setText: @"Klicka för att välja klass"];
            }
            else
            {
                SchoolClass *schoolClass = [_schoolClasses objectAtIndex: indexPath.row];
                [cell.textLabel setText: schoolClass.title];
                [cell.detailTextLabel setText: @""];
            }
            return cell;
        }
        
        case SubjectSection:
        {
            switch (indexPath.row)
            {
                case SubjectNameRow:
                {
                    ExpandableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier: ExpandableHeaderCellIdentifier];
                    [cell.detailTextLabel setText: @"Ämne"];
                    [cell.textLabel setText: _subject.name];
                    if (subjectSectionExpanded)
                    {
                        [cell.expandLabel setText: @"Dölj detaljer"];
                    }
                    else
                    {
                        [cell.expandLabel setText: @"Visa detaljer"];
                    }
                    return cell;
                }
                case SubjectIntroCaptionRow:
                {
                    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
                    [cell setText: [_subject introCaption] expanded: subjectIntroCaptionRowExpanded];
                    [cell setTitle: @""];
                    return cell;
                }
                case SubjectObjectiveCaptionRow:
                {
                    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TextTableViewCellIdentifier];
                    [cell setText: [_subject objectiveCaption] expanded: subjectObjectiveCaptionRowExpanded];
                    [cell setTitle: @"Ämnets syfte"];
                    return cell;
                }
            }
        }
        case SubjectObjectivesSection:
        {
            if (indexPath.row == 0)
            {
                SubjectiveObjectiveHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SubjectiveObjectiveHeaderTableViewCellIdentifier];
                cell.title = _subject.objectiveItemHeader;
                return cell;
            }
            else
            {
                NSArray *subjectObjectives = _subject.sortedObjectivesItems;
                SubjectObjectiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SubjectObjectiveTableViewCellIdentifier];
                [cell setObjective: [subjectObjectives objectAtIndex: indexPath.row - 1]];
                return cell;
            }
        }
        
        case CourseEditionSection:
        {
            ExpandableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier: ExpandableHeaderCellIdentifier];
            
            [cell.detailTextLabel setText: @"Kurs"];
            [cell.textLabel setText: [NSString stringWithFormat: @"%@, %@",_courseDescription.name, _courseDescription.level]];
            if (courseSectionExpanded)
            {
                [cell.expandLabel setText: @"Dölj detaljer"];
            }
            else
            {
                [cell.expandLabel setText: @"Visa detaljer"];
            }
            return cell;
        }
        case CourseContentItemSection:
        {
            NSArray *contentItems = _courseDescription.sortedCentralContentItems;
            CentralContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CentralContentTableViewCellIdentifier];
            [cell setCentralContent: [contentItems objectAtIndex: indexPath.row]];
            return cell; 
        }
        case CourseAquirementSection:
        {
            NSArray *courseAquirements = _courseDescription.sortedCourseAquirements;
            AquirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: AquirementTableViewCellIdentifier];
            [cell setAquirementDescription: [courseAquirements objectAtIndex: indexPath.row]];
            return cell;
        }
    }
    NSLog(@"IndexPath section out of range.");
    return nil;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SchoolClassSection: return (_schoolClasses.count) ? _schoolClasses.count : 1;
        case SubjectSection: return (subjectSectionExpanded) ? 3 : 1;
        case SubjectObjectivesSection: return (subjectSectionExpanded) ? _subject.sortedObjectivesItems.count + 1 : 0;
        case CourseEditionSection: return 1;
        case CourseContentItemSection: return (courseSectionExpanded) ? [_courseDescription.sortedCentralContentItems count] : 0;
        case CourseAquirementSection: return (courseSectionExpanded) ? _courseDescription.sortedCourseAquirements.count : 0;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case SchoolClassSection: return 40.f;
        case SubjectSection:
        {
            switch (indexPath.row)
            {
                case SubjectNameRow: return 55.f;
                case SubjectIntroCaptionRow: return [TextTableViewCell heightForText: _subject.introCaption expanded: subjectIntroCaptionRowExpanded];
                    
                case SubjectObjectiveCaptionRow: return [TextTableViewCell heightForText: _subject.objectiveCaption expanded: subjectObjectiveCaptionRowExpanded];
            }
        }
        case SubjectObjectivesSection: return 40.f;
        case CourseEditionSection: return 55.f;
        case CourseContentItemSection: return 40.f;
        case CourseAquirementSection: return 32.f;
    }
    return 0;
}


#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SchoolClassSection)
    {
        [self performSegueWithIdentifier: SelectStudentsIdentifier sender:self];
        //[self performSegueWithIdentifier: SelectClassSegueIdentifier sender: self];
    }
    if (indexPath.section == SubjectSection)
    {
        switch (indexPath.row) {
            case SubjectNameRow:
            {
                subjectSectionExpanded ^= YES;
                [_tableView beginUpdates];
                [tableView reloadSections: [NSIndexSet indexSetWithIndex: SubjectSection]  withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView reloadSections: [NSIndexSet indexSetWithIndex: SubjectObjectivesSection]  withRowAnimation:UITableViewRowAnimationAutomatic];
                [_tableView endUpdates];
                
                return;
            }
            case SubjectIntroCaptionRow: subjectIntroCaptionRowExpanded ^= YES; break;
            case SubjectObjectiveCaptionRow: subjectObjectiveCaptionRowExpanded ^= YES; break;
            default: return;
        }
        [_tableView beginUpdates];
        [_tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }
    if (indexPath.section == CourseEditionSection)
    {
        courseSectionExpanded ^= YES;
        [_tableView beginUpdates];
        [tableView reloadSections: [NSIndexSet indexSetWithIndex: CourseContentItemSection]  withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadSections: [NSIndexSet indexSetWithIndex: CourseAquirementSection]  withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView endUpdates];
        return;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: SelectClassSegueIdentifier])
    {
        SelectionTableViewController *stvc = segue.destinationViewController;
        [stvc setSelectionStyle: MultiSelectionStyle];
        [stvc setObjects: [SchoolClass schoolClassesForCurrentTeacher]];
        [stvc setSelectedObjects: _schoolClasses];
        [stvc setSetupCellWithObject:^(UITableViewCell *cell, NSManagedObject *object) {
            SchoolClass *schoolClass = (SchoolClass*) object;
            [cell.textLabel setText: [NSString stringWithFormat: @"%@%@",
                                      schoolClass.year, schoolClass.suffix]];
            [cell.detailTextLabel setText: schoolClass.school.name];
        }];
        [stvc setOnDone:^(NSArray *selectedObjects) {
            self.schoolClasses = selectedObjects;
            [_tableView beginUpdates];
            [_tableView reloadSections: [NSIndexSet indexSetWithIndex: SchoolClassSection] withRowAnimation: UITableViewRowAnimationAutomatic];
            [_tableView endUpdates];
        }];
    }
    else if ([segue.identifier isEqualToString: SelectStudentsIdentifier])
    {
        UINavigationController *nc = (UINavigationController*) segue.destinationViewController;
        SchoolTableViewController *stvc = (SchoolTableViewController*) [nc.viewControllers objectAtIndex: 0];
        [stvc setSchools: [School schoolsForCurrentTeacher]];
    }
}

#pragma mark - IBAction Methods

- (IBAction) save:(id)sender
{
    NSManagedObjectContext *moc =  [AppDelegate sharedDelegate].managedObjectContext;
    for (SchoolClass *schoolClass in _schoolClasses)
    {
        Course *course = [Course courselWithDict: @{} inManagedObjectContext: moc];
        course.courseEdition = _courseEdition;
        course.schoolClass = schoolClass;
        course.teacher = [Session currentSession].teacher;
        [course enrollClass: schoolClass managedObjectContext: moc];
    }
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) cancel :(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Getters and Setters

@synthesize courseEdition = _courseEdition;
@synthesize courseDescription = _courseDescription;
@synthesize subject = _subject;
@synthesize schoolClasses = _schoolClasses;

- (void) setSchoolClasses:(NSArray *)schoolClasses
{
    _schoolClasses = schoolClasses.mutableCopy;
}

@synthesize inEditMode = _inEditMode;


@end
